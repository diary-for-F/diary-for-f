import json
import os
import pymysql
import boto3
from datetime import datetime, timedelta


# DB 연결
def get_db_connection():
    secret = json.loads(os.getenv("DB_SECRETS"))
    return pymysql.connect(host=secret["host"],
                           port=int(secret["port"]),
                           user=secret["username"],
                           password=secret["password"],
                           db=secret["dbname"],
                           charset="utf8mb4",
                           cursorclass=pymysql.cursors.DictCursor)


# 감정 이름 → emotion_id 변환
def get_emotion_id(cursor, name):
    cursor.execute("SELECT emotion_id FROM emotions WHERE name = %s", (name, ))
    result = cursor.fetchone()
    if not result:
        raise ValueError(f"Emotion '{name}' not found in emotions table.")
    return result["emotion_id"]


# Claude에 감정 분석 요청
def analyze_emotion_with_bedrock(content, selected_emotions):
    # Claude에 허용할 감정 목록을 명시
    allowed_emotions = [
        "joy", "sadness", "anger", "fear", "surprise", "neutral"
    ]

    prompt = f"""
당신은 따뜻한 말로 사람의 감정을 공감하고 위로하는 감성적인 심리상담사입니다.
사용자가 작성한 일기에는 지치고 힘든 감정이 담겨 있습니다.

다음 일기 내용을 분석하여 다음을 수행해 주세요:
1. 감정 분석 결과를 joy, sadness, anger, fear, surprise, neutral 중 최대 3개까지 선정하고 각각 0~100 점수로 정리
2. 충분히 공감한 뒤, 진심을 담아 따뜻한 위로 문장을 2~3줄로 한국어로 작성 (형식: 존댓말, 진심 어린 표현, 감정적 거리감 없음)

반드시 아래 JSON 형식으로 응답하세요:
{{
  "results": [
    {{ "emotion": "sadness", "score": 85 }},
    {{ "emotion": "anger", "score": 70 }},
    {{ "emotion": "joy", "score": 55 }}
  ],
  "message": "진심이 느껴지는 위로 문장을 한국어로 작성해 주세요."
}}

User-selected Emotions (with their levels): {", ".join([f'{e["emotion"]}({e["level"]})' for e in selected_emotions])}
Diary Content: {content}
""".strip()

    body = {
        "anthropic_version":
        "bedrock-2023-05-31",
        "max_tokens":
        1024,
        "temperature":
        0.7,
        "messages": [{
            "role": "user",
            "content": [{
                "type": "text",
                "text": prompt
            }]
        }]
    }

    client = boto3.client("bedrock-runtime", region_name="ap-northeast-2")
    response = client.invoke_model(
        modelId="anthropic.claude-3-5-sonnet-20240620-v1:0",
        body=json.dumps(body),
        contentType="application/json",
        accept="application/json")

    result = json.loads(response["body"].read())
    parsed = json.loads(result["content"][0]["text"].strip())
    return parsed["results"], parsed["message"]


# 감정 레벨 저장 함수
def insert_emotion_levels(cursor, emotions, diary_id, is_prediction=False):
    for e in emotions:
        name = e["emotion"]
        level = e["score"] if is_prediction else e["level"]
        emotion_id = get_emotion_id(cursor, name)
        cursor.execute(
            "INSERT INTO diary_entry_emotions (emotion_id, diary_id, level) VALUES (%s, %s, %s)",
            (emotion_id, diary_id, level))


# Lambda entry point
def lambda_handler(event, context):
    try:
        body = event.get("body", event)
        if isinstance(body, str):
            body = json.loads(body)

        content = body.get("content")
        selected = body.get("selectedEmotions")

        if not content or not selected:
            return {
                "statusCode":
                400,
                "body":
                json.dumps({"error": "Missing content or selectedEmotions"})
            }

        conn = get_db_connection()
        cursor = conn.cursor()

        # AI 분석 요청
        top_emotions, message = analyze_emotion_with_bedrock(content, selected)
        main_emotion_id = get_emotion_id(cursor, top_emotions[0]["emotion"])

        #9시간 더해서 KST 저장
        now_kst = datetime.utcnow() + timedelta(hours=9)

        # 일기 저장
        cursor.execute(
            "INSERT INTO diary_entries (content, ai_feedback, main_emotion_id, created_at) VALUES (%s, %s, %s, %s)",
            (content, message, main_emotion_id, now_kst))
        diary_id = cursor.lastrowid

        # 감정 레벨 저장 (사용자 선택 / AI 예측)
        insert_emotion_levels(cursor, selected, diary_id, is_prediction=False)
        insert_emotion_levels(cursor,
                              top_emotions,
                              diary_id,
                              is_prediction=True)

        conn.commit()
        cursor.close()
        conn.close()

        return {
            "statusCode":
            201,
            "body":
            json.dumps(
                {
                    "id": diary_id,
                    "createdAt": now_kst.strftime("%Y-%m-%d %H:%M:%S"),
                    "topEmotions": top_emotions,
                    "message": message
                },
                ensure_ascii=False)
        }

    except Exception as e:
        return {"statusCode": 500, "body": json.dumps({"error": str(e)})}

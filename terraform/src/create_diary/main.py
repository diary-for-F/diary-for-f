import json
import os
import pymysql
import boto3
def get_db_connection():
    secret = json.loads(os.getenv("DB_SECRETS"))
    return pymysql.connect(
        host=secret["host"],
        port=int(secret["port"]),
        user=secret["username"],
        password=secret["password"],
        db=secret["dbname"],
        charset="utf8mb4",
        cursorclass=pymysql.cursors.DictCursor
    )
def get_emotion_id(cursor, name):
    cursor.execute("SELECT emotion_id FROM emotions WHERE name = %s", (name,))
    result = cursor.fetchone()
    if not result:
        raise ValueError(f"Emotion '{name}' not found in emotions table.")
    return result["emotion_id"]
def analyze_emotion_with_bedrock(content, selected_emotions):
    # Claude에게 영어 감정명을 요구
    prompt = f"""
Please analyze the following diary and respond in JSON format as below:
{{
  "results": [
    {{ "emotion": "sadness", "score": 85 }},
    {{ "emotion": "anger", "score": 70 }},
    {{ "emotion": "joy", "score": 55 }}
  ],
  "message": "위로 문장을 한국어로 작성해주세요."
}}
Selected Emotions: {", ".join([f'{e["emotion"]}({e["level"]})' for e in selected_emotions])}
Content: {content}
""".strip()
    body = {
        "anthropic_version": "bedrock-2023-05-31",
        "max_tokens": 1024,
        "temperature": 0.7,
        "messages": [
            {
                "role": "user",
                "content": [{"type": "text", "text": prompt}]
            }
        ]
    }
    client = boto3.client("bedrock-runtime", region_name="ap-northeast-2")
    response = client.invoke_model(
        modelId="anthropic.claude-3-5-sonnet-20240620-v1:0",
        body=json.dumps(body),
        contentType="application/json",
        accept="application/json"
    )
    result = json.loads(response["body"].read())
    parsed = json.loads(result["content"][0]["text"].strip())
    return parsed["results"], parsed["message"]
def insert_emotion_levels(cursor, emotions, diary_id, is_prediction=False):
    for e in emotions:
        name = e["emotion"]
        level = e["score"] if is_prediction else e["level"]
        emotion_id = get_emotion_id(cursor, name)
        cursor.execute(
            "INSERT INTO diary_entry_emotions (emotion_id, diary_id, level) VALUES (%s, %s, %s)",
            (emotion_id, diary_id, level)
        )
def lambda_handler(event, context):
    try:
        body = event.get("body", event)
        if isinstance(body, str):
            body = json.loads(body)
        content = body.get("content")
        selected = body.get("selectedEmotions")
        if not content or not selected:
            return {
                "statusCode": 400,
                "body": json.dumps({"error": "Missing content or selectedEmotions"})
            }
        conn = get_db_connection()
        cursor = conn.cursor()
        # AI 분석 요청
        top_emotions, message = analyze_emotion_with_bedrock(content, selected)
        main_emotion_id = get_emotion_id(cursor, top_emotions[0]["emotion"])
        # 일기 저장
        cursor.execute(
            "INSERT INTO diary_entries (content, ai_feedback, main_emotion_id) VALUES (%s, %s, %s)",
            (content, message, main_emotion_id)
        )
        diary_id = cursor.lastrowid
        # 감정 레벨 저장
        insert_emotion_levels(cursor, selected, diary_id, is_prediction=False)
        insert_emotion_levels(cursor, top_emotions, diary_id, is_prediction=True)
        conn.commit()
        cursor.close()
        conn.close()
        return {
            "statusCode": 201,
            "body": json.dumps({
                "id": diary_id,
                "topEmotions": top_emotions,
                "message": message
            })
        }
    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }

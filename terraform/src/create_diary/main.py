import json
import pymysql
import boto3
import openai

def get_db_connection():
    secret_name = "diary-for-f/aurora-credentials"
    region_name = "ap-northeast-2"
    client = boto3.client("secretsmanager", region_name=region_name)
    response = client.get_secret_value(SecretId=secret_name)
    secret = json.loads(response['SecretString'])

    openai.api_key = secret["openai_api_key"]

    return pymysql.connect(
        host=secret["host"],
        port=int(secret["port"]),
        user=secret["username"],
        password=secret["password"],
        db=secret["dbname"],
        charset="utf8mb4",
        cursorclass=pymysql.cursors.DictCursor
    ), secret

def analyze_emotion(content, selected_emotions):
    emotion_str = ", ".join([f'{e["emotion"]}({e["level"]})' for e in selected_emotions])
    prompt = f"""
    사용자의 감정일기를 분석해서 아래와 같이 응답해주세요:
    {{
      "results": [
        {{ "emotion": "슬픔", "score": 85 }},
        ...
      ],
      "message": "위로 문장"
    }}

    선택 감정: {emotion_str}
    내용: {content}
    """
    response = openai.ChatCompletion.create(
        model="gpt-4",
        messages=[
            {"role": "system", "content": "감정 분석 전문가로 행동해줘."},
            {"role": "user", "content": prompt}
        ]
    )
    parsed = json.loads(response.choices[0].message["content"])
    return parsed["results"], parsed["message"]

def lambda_handler(event, context):
    body = json.loads(event["body"])
    content = body.get("content")
    selected = body.get("selectedEmotions")

    if not content or not selected:
        return { "statusCode": 400, "body": "Missing content or emotions" }

    try:
        conn, secret = get_db_connection()
        top_emotions, message = analyze_emotion(content, selected)

        cur = conn.cursor()
        cur.execute("""
            INSERT INTO diary_entries (
                content, selected_emotions, selected_levels,
                predicted_emotions, predicted_levels,
                main_emotion, ai_feedback
            ) VALUES (%s, %s, %s, %s, %s, %s, %s)
        """, (
            content,
            [e["emotion"] for e in selected],
            [e["level"] for e in selected],
            [e["emotion"] for e in top_emotions],
            [e["score"] for e in top_emotions],
            top_emotions[0]["emotion"],
            message
        ))
        conn.commit()
        diary_id = cur.lastrowid
        cur.close()
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
            "body": json.dumps({ "error": str(e) })
        }
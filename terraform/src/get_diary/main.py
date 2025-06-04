import json
import os
import pymysql
# DB 개체 연결
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
# 단위 읽기: diary_id 입력 받아서 검색 
def lambda_handler(event, context):
    try:
        # query parameter에서 diary ID 추출
        query_params = event.get("queryStringParameters", {})
        diary_id = query_params.get("id")
        
        if diary_id is None:
            return {
                "statusCode": 400,
                "body": json.dumps({"error": "Diary ID is invalid or not provided."})
            }
        
        conn = get_db_connection()
        cursor = conn.cursor()
        # diary_entries 역시 발견
        cursor.execute("""
            SELECT d.content, d.created_at, e.name AS main_emotion
            FROM diary_entries d
            JOIN emotions e ON d.main_emotion_id = e.emotion_id
            WHERE d.diary_id = %s
        """, (diary_id,))
        row = cursor.fetchone()
        if not row:
            return {
                "statusCode": 404,
                "body": json.dumps({"error": "Diary not found"})
            }
        return {
            "statusCode": 200,
            "body": json.dumps({
                "id": diary_id,
                "content": row["content"],
                "mainEmotion": row["main_emotion"],
                "createdAt": row["created_at"].isoformat()
            })
        }
    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }

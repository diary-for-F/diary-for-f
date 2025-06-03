import json
import os
import pymysql

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

def lambda_handler(event, context):
    try:
        # 쿼리 파라미터 파싱
        params = event.get("queryStringParameters") or {}
        page = max(int(params.get("page", 1)), 1)
        limit = max(int(params.get("limit", 10)), 1)
        offset = (page - 1) * limit

        # DB 연결
        conn = get_db_connection()
        cursor = conn.cursor()

        # 일기 목록 조회
        cursor.execute("""
            SELECT d.diary_id, 
                   LEFT(d.content, 25) AS preview,
                   d.created_at, 
                   e.name AS main_emotion
            FROM diary_entries d
            JOIN emotions e ON d.main_emotion_id = e.emotion_id
            ORDER BY d.created_at DESC
            LIMIT %s OFFSET %s
        """, (limit, offset))

        rows = cursor.fetchall()
        cursor.close()
        conn.close()

        return {
            "statusCode": 200,
            "body": json.dumps([
                {
                    "id": row["diary_id"],
                    "content": row["preview"],
                    "mainEmotion": row["main_emotion"],
                    "createdAt": row["created_at"].strftime("%Y-%m-%d %H:%M:%S")
                } for row in rows
            ], ensure_ascii=False)
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }
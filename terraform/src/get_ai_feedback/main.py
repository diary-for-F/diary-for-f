import json
import os
import pymysql
#일기 뒷면 조회
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
        # path에서 diary_id 추출
        query_params = event.get("queryStringParameters", {})
        diary_id = query_params.get("id")
        
        if diary_id is None:
            return {
                "statusCode": 400,
                "body": json.dumps({"error": "Diary ID is invalid or not provided."})
            }
       
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("""
            SELECT ai_feedback, created_at
            FROM diary_entries
            WHERE diary_id = %s
        """, (diary_id,))
        row = cur.fetchone()
        cur.close()
        conn.close()
        if not row:
            return {
                "statusCode": 404,
                "body": json.dumps({"error": "Diary not found"})
            }
        return {
            "statusCode": 200,
            "body": json.dumps({
                "ai_feedback": row["ai_feedback"],
                "created_at": row["created_at"].strftime("%Y-%m-%d %H:%M:%S")
            })
        }
    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }

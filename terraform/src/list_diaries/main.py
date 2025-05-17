import json
import pymysql
import boto3

def get_db_connection():
    secret_name = "diary-for-f/aurora-credentials"
    region_name = "ap-northeast-2"
    client = boto3.client("secretsmanager", region_name=region_name)
    response = client.get_secret_value(SecretId=secret_name)
    secret = json.loads(response['SecretString'])

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
    query = event.get("queryStringParameters") or {}
    page = int(query.get("page", 1))
    limit = int(query.get("limit", 10))
    offset = (page - 1) * limit

    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("""
            SELECT id, main_emotion, created_at 
            FROM diary_entries 
            ORDER BY created_at DESC 
            LIMIT %s OFFSET %s
        """, (limit, offset))
        rows = cur.fetchall()
        cur.close()
        conn.close()

        diaries = [
            {
                "id": row["id"],
                "mainEmotion": row["main_emotion"],
                "date": row["created_at"].date().isoformat()
            } for row in rows
        ]

        return {
            "statusCode": 200,
            "body": json.dumps(diaries)
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({ "error": str(e) })
        }
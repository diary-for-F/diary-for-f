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
    path = event.get("path")
    diary_id = path.split("/")[-1]

    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("""
            SELECT id, content, selected_emotions, selected_levels,
                   predicted_emotions, predicted_levels, ai_feedback, created_at
            FROM diary_entries
            WHERE id = %s
        """, (diary_id,))
        row = cur.fetchone()
        cur.close()
        conn.close()

        if not row:
            raise Exception("Diary not found")

        return {
            "statusCode": 200,
            "body": json.dumps({
                "id": row["id"],
                "content": row["content"],
                "selectedEmotions": [
                    { "emotion": e, "level": l }
                    for e, l in zip(row["selected_emotions"], row["selected_levels"])
                ],
                "topEmotions": [
                    { "emotion": e, "score": s }
                    for e, s in zip(row["predicted_emotions"], row["predicted_levels"])
                ],
                "message": row["ai_feedback"],
                "createdAt": row["created_at"].isoformat()
            })
        }

    except Exception as e:
        return {
            "statusCode": 404,
            "body": json.dumps({ "error": str(e) })
        }   
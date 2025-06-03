import json
import pymysql
import boto3


def get_db_connection():
    secret_name = "diary-for-f/aurora-credentials"
    region_name = "ap-northeast-2"
    client = boto3.client("secretsmanager", region_name=region_name)
    response = client.get_secret_value(SecretId=secret_name)
    secret = json.loads(response['SecretString'])

    connection = pymysql.connect(
        host=secret["host"],
        port=int(secret["port"]),
        user=secret["username"],
        password=secret["password"],
        db=secret["dbname"],
        charset="utf8mb4",
        cursorclass=pymysql.cursors.DictCursor
    )
    return connection


def lambda_handler(event, context):
    print("🚀 [calendar_view] Lambda started")
    
    try:
        query = event.get("queryStringParameters", {})
        start_date = query.get("startDate")
        end_date = query.get("endDate")

        if not start_date or not end_date:
            return {
                "statusCode": 400,
                "body": json.dumps({ "error": "Missing startDate or endDate" })
            }

        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("""
            SELECT id, DATE(created_at) as date, main_emotion
            FROM diary_entries
            WHERE DATE(created_at) BETWEEN %s AND %s
            ORDER BY created_at ASC
        """, (start_date, end_date))
        results = cur.fetchall()
        cur.close()
        conn.close()

        print(f"✅ [calendar_view] Fetched {len(results)} records")
        return {
            "statusCode": 200,
            "body": json.dumps(results, ensure_ascii=False)
        }

    except Exception as e:
        print(f"❌ [calendar_view] ERROR: {e}")
        return {
            "statusCode": 500,
            "body": json.dumps({ "error": str(e) })
        }
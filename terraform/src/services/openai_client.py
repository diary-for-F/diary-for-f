import openai
import os

openai.api_key = os.environ.get("OPENAI_API_KEY")

def analyze_emotion(content, selected_emotions):
    prompt = f"""
사용자 감정: {selected_emotions}
일기 내용: {content}

이걸 바탕으로 상위 감정 3개와 점수(0~100), 위로 메시지를 JSON으로 줘:
    """

    response = openai.ChatCompletion.create(
        model="gpt-4",
        messages=[
            { "role": "system", "content": "너는 감정 분석 전문가야." },
            { "role": "user", "content": prompt }
        ]
    )

    result = response.choices[0].message.content
    parsed = json.loads(result)
    return parsed["results"], parsed["message"]
import SwiftUI

/*
 사진 한 줄을 표현하는 뷰
 */
struct PhotoLineView: View {
    let entries: [DiaryEntry]
    var onTap: (DiaryEntry) -> Void

    var body: some View {
        ZStack(alignment: .top) {
            // 곡선 줄
            GeometryReader { geo in
                Path { path in
                    let width = geo.size.width
                    path.move(to: CGPoint(x:0, y:20))
                    path.addQuadCurve(to: CGPoint(x: width, y:20), // 아래로 쳐진 곡선
                                      control: CGPoint(x: width / 2, y: 60)) // 곡률 조정
                }
                .stroke(Color(red: 170/255, green: 136/255, blue: 119/255), lineWidth: 5)
            }
            .frame(height: 50) // 충분한 높이 필요

            // 가로 스크롤 가능한 카드 리스트
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(entries) { entry in
                        let rotation = Double.random(in: -7...7)
                        let yOffset : CGFloat = abs(rotation) >= 5 ? 4 : 10 // 사진 기울기에 따른 오프셋 조정
 
                        DiaryCardView(content: entry.content, dateText: entry.date, emotionImageName: entry.emotionImageName)
                            .frame(width: 130, height: 160)
                            .rotationEffect(.degrees(rotation))
                            .offset(y: yOffset) // 줄과 사진 사이의 거리 조절
                            .contentShape(Rectangle())
                            .onTapGesture { // 터치 가능하게
                                onTap(entry)
                            }
                    }
                }
                .padding(.horizontal, Double.random(in: -10...20))
                .padding(.vertical, 20)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 120)
    }
}

#Preview {
    PhotoLineView(
        entries: [
            .init(
                date: "2025.05.01",
                timestamp: "2025.05.01 18:20",
                emotionImageName: "sad",
                content: "요즘 들어 자꾸 불안한 생각이 머릿속을 맴돕니다.",
                aiReply: "지금 느끼는 불안은 당신이 소중한 무언가를 지키고 있다는 증거예요.",
                aiImageName: "robot"
            ),
            .init(
                date: "2025.05.02",
                timestamp: "2025.05.02 09:15",
                emotionImageName: "joy",
                content: "아침에 상쾌한 공기를 마시며 산책했어요.",
                aiReply: "아침 산책으로 기분이 한결 나아졌군요. 오늘도 좋은 하루 보내세요!",
                aiImageName: "robot"
            ),
            .init(
                date: "2025.05.03",
                timestamp: "2025.05.03 12:00",
                emotionImageName: "angry",
                content: "회의 중에 제 의견이 반영되지 않아 답답했어요.",
                aiReply: "답답하셨겠어요. 다음 번엔 더 좋은 피드백이 따를 거예요.",
                aiImageName: "robot"
            ),
            .init(
                date: "2025.05.04",
                timestamp: "2025.05.04 20:30",
                emotionImageName: "neutral",
                content: "그저 평범한 하루였어요.",
                aiReply: "평범함도 때로는 큰 휴식이 되어줍니다.",
                aiImageName: "robot"
            ),
            .init(
                date: "2025.05.05",
                timestamp: "2025.05.05 22:10",
                emotionImageName: "surprised",
                content: "회사에서 깜짝 칭찬 메시지를 받았어요!",
                aiReply: "뜻밖의 칭찬은 정말 힘이 되죠. 축하드려요!",
                aiImageName: "robot"
            ),
            .init(
                date: "2025.05.06",
                timestamp: "2025.05.06 08:45",
                emotionImageName: "anxious",
                content: "다음 주 발표 준비가 아직 덜 돼서 조마조마해요.",
                aiReply: "준비가 잘 되고 있어요. 자신감을 가져도 좋습니다!",
                aiImageName: "robot"
            ),
            .init(
                date: "2025.05.07",
                timestamp: "2025.05.07 14:20",
                emotionImageName: "joy",
                content: "점심으로 맛있는 파스타를 먹었더니 기분이 좋네요.",
                aiReply: "맛있는 음식으로 기분 전환하셨군요. 즐거운 순간이에요!",
                aiImageName: "robot"
            )
        ],
        onTap: { entry in
            // Preview 용 탭 액션 (실제 로직 없음)
            print("Tapped on \(entry.date) at \(entry.timestamp)")
        }
    )
}

import SwiftUI

/*
 사진 한 줄을 표현하는 뷰
 */
struct PhotoLineView: View {
    let entries: [DiaryEntry] // DiaryEntry(date: "2025.05.01", emotionImageName: .happy)
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
 
                        DiaryCardView(dateText: entry.date, emotionImageName: entry.emotionImageName)
                            .rotationEffect(.degrees(rotation))
                            .offset(y: yOffset) // 줄과 사진 사이의 거리 조절
                            .contentShape(Rectangle())
                            .onTapGesture { // 터치 가능하게
                                onTap(entry)
                            }
                    }
                }
                .padding(.horizontal, Double.random(in: 0...40))
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
                content: "요즘 들어 자꾸 불안한 생각이 머릿속을 맴돕니다."
            ),
            .init(
                date: "2025.05.02",
                timestamp: "2025.05.02 09:15",
                emotionImageName: "happy",
                content: "아침에 상쾌한 공기를 마시며 산책했어요."
            ),
            .init(
                date: "2025.05.03",
                timestamp: "2025.05.03 12:00",
                emotionImageName: "angry",
                content: "회의 중에 제 의견이 반영되지 않아 답답했어요."
            ),
            .init(
                date: "2025.05.04",
                timestamp: "2025.05.04 20:30",
                emotionImageName: "neutral",
                content: "그저 평범한 하루였어요."
            ),
            .init(
                date: "2025.05.05",
                timestamp: "2025.05.05 22:10",
                emotionImageName: "surprised",
                content: "회사에서 깜짝 칭찬 메시지를 받았어요!"
            ),
            .init(
                date: "2025.05.06",
                timestamp: "2025.05.06 08:45",
                emotionImageName: "anxious",
                content: "다음 주 발표 준비가 아직 덜 돼서 조마조마해요."
            ),
            .init(
                date: "2025.05.07",
                timestamp: "2025.05.07 14:20",
                emotionImageName: "happy",
                content: "점심으로 맛있는 파스타를 먹었더니 기분이 좋네요."
            )
        ],
        onTap: { entry in
            // Preview 용 탭 액션 (실제 로직 없음)
            print("Tapped on \(entry.date) at \(entry.timestamp)")
        }
    )
}

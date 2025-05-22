import SwiftUI

/*
 사진 한 줄을 표현하는 뷰
 */
struct PhotoLineView: View {
    let entries: [DiaryEntry] // DiaryEntry(date: "2025.05.01", emotionImageName: .happy)

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
    PhotoLineView(entries: [
        .init(date: "2025.05.01", emotionImageName: "sad"),
        .init(date: "2025.05.02", emotionImageName: "happy"),
        .init(date: "2025.05.03", emotionImageName: "angry"),
        .init(date: "2025.05.04", emotionImageName: "neutral"),
        .init(date: "2025.05.05", emotionImageName: "surprised"),
        .init(date: "2025.05.06", emotionImageName: "anxious"),
        .init(date: "2025.05.07", emotionImageName: "happy")
    ])
}

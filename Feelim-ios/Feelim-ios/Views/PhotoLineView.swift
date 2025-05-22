import SwiftUI

struct PhotoLineView: View {
    let entries: [DiaryEntry] // DiaryEntry(date: "2025.05.01", emotionImageName: .happy)

    var body: some View {
        ZStack(alignment: .top) {
            // 갈색 줄 (줄은 좌우로 길게 이어지게)
            Rectangle()
                .fill(Color(red: 173/255, green: 122/255, blue: 92/255))
                .frame(height: 4)
                .offset(y: 25)

            // 가로 스크롤 가능한 카드 리스트
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(entries) { entry in
                        DiaryCardView(dateText: entry.date, emotionImageName: entry.emotionImageName)
                            .rotationEffect(.degrees(Double.random(in: -5...5)))
                    }
                }
                .padding(.horizontal, 40) // TODO : 0 ~ 40사이의 숫자 중 랜덤으로 생성
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

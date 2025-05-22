//
//  HomeView.swift
//  Feelim-ios
//
//  Created by 김동인 on 5/19/25.
//

import SwiftUI

struct HomeView: View {
    // 여러 줄의 감정 일기들 샘플
    let photoLines: [[DiaryEntry]] = [
        [
            DiaryEntry(date: "2025.05.01", emotionImageName: "sad"),
            DiaryEntry(date: "2025.05.02", emotionImageName: "happy"),
            DiaryEntry(date: "2025.05.02", emotionImageName: "neutral"),
            DiaryEntry(date: "2025.05.02", emotionImageName: "angry"),
            DiaryEntry(date: "2025.05.02", emotionImageName: "anxious"),
            DiaryEntry(date: "2025.05.02", emotionImageName: "happy"),
            DiaryEntry(date: "2025.05.02", emotionImageName: "surprised")
        ],
        [
            DiaryEntry(date: "2025.04.25", emotionImageName: "angry"),
            DiaryEntry(date: "2025.04.26", emotionImageName: "happy")
        ],
        [
            DiaryEntry(date: "2025.04.25", emotionImageName: "angry"),
            DiaryEntry(date: "2025.04.26", emotionImageName: "happy"),
            DiaryEntry(date: "2025.05.02", emotionImageName: "anxious"),
            DiaryEntry(date: "2025.05.02", emotionImageName: "happy"),
            DiaryEntry(date: "2025.05.02", emotionImageName: "surprised")
        ],
        [
            DiaryEntry(date: "2025.04.25", emotionImageName: "angry"),
            DiaryEntry(date: "2025.04.26", emotionImageName: "happy"),
            DiaryEntry(date: "2025.05.02", emotionImageName: "anxious"),
            DiaryEntry(date: "2025.05.02", emotionImageName: "happy")
        ],
        [
            DiaryEntry(date: "2025.04.25", emotionImageName: "angry"),
            DiaryEntry(date: "2025.04.26", emotionImageName: "happy")
        ]
    ]

    var body: some View {
        ZStack {
            Color(red: 0.15, green: 0.15, blue: 0.15)
                .ignoresSafeArea()

            VStack(spacing: 10) {
                // 상단 로고 텍스트
                Text("Feel:Im")
                    .font(.custom("Silom", size: 32))
                    .foregroundColor(Color(red: 0.15, green: 0.15, blue: 0.15))
                    .padding(.top, 24)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .frame(height: 40)
                    )

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 64) {
                        ForEach(photoLines.indices, id: \.self) { index in
                            PhotoLineView(entries: photoLines[index])
                        }
                    }
                    .padding(.vertical, 0)
                }

                Spacer()
            }

            // 플로팅 버튼
            VStack {
                Spacer()
                Button(action: {
                    // 새 일기 추가 액션
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.gray.opacity(0.4))
                            .frame(width: 64, height: 64)
                        Text("+")
                            .font(.custom("Arial", size: 24))
                            .foregroundColor(.white)
                    }
                }
                .padding(.bottom, 30)
            }
        }
    }
}

#Preview {
    HomeView()
}

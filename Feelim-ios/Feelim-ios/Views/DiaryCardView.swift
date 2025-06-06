//
//  DiaryCardView.swift
//  Feelim-ios
//
//  Created by 김동인 on 5/19/25.
//

import SwiftUI

struct DiaryCardView: View {
    let content: String
    let dateText: String
    let emotionImageName: String // 예) "joy", "sadness"

    var body: some View {
        ZStack {
            // 그림자 포함된 흰색 폴라로이드 배경
            RoundedRectangle(cornerRadius: 0)
                .fill(Color.white)
                .frame(width: 110, height: 135)
                .shadow(color: Color.black.opacity(0.1), radius: 3.07, x: 0, y: 0)

            VStack(spacing: 2) {
                // 이미지 영역 (검은 네모 + 날짜 텍스트)
                ZStack {
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: 98, height: 99)
                        .offset(y: -3)
                    
                    Text(trimmedContent(content))
                        .font(.custom("Nanum Pen", size: 12).weight(.medium))
                        .italic()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 9)
                        .lineLimit(3) // 최대 3줄만 표시
                        .offset(y: 0)
                    
                    // 감정 이모지
                    Image(emotionImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                        .offset(y: -60)
                }
                
                // 날짜 텍스트
                Text(dateText)
                    .font(.custom("Nanum Pen", size: 20))
                    .foregroundColor(.black)
                    .offset(y: 3)
            }
        }
        .frame(width: 110, height: 135)
    }
    
    // 간단히 너무 긴 content 자르기
    private func trimmedContent(_ content: String) -> String {
        if content.count > 30 {
            return String(content.prefix(30)) + "..."
        }
        return content
    }
}

#Preview {
    DiaryCardView(content: "이것은 일기 이것은 일기 이것은 일기 이것은 일기 이것은 일기 이것은 일기 이것은 일기 이것은 일기 이것은 일기",dateText: "2025.05.01", emotionImageName: "joy")
}

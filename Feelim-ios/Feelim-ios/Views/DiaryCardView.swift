//
//  DiaryCardView.swift
//  Feelim-ios
//
//  Created by 김동인 on 5/19/25.
//

import SwiftUI

struct DiaryCardView: View {
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
                
                    // 날짜 텍스트
                    Text(dateText)
                        .font(.custom("Nanum Pen", size: 20).weight(.medium))
                        .italic()
                        .foregroundColor(.white)
                    
                    // 감정 이모지
                    Image(emotionImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                        .offset(y: -60)
                }
                
                // 고정 텍스트
                Text("Polaroid 600 Format")
                    .font(.custom("Roboto", size: 7))
                    .foregroundColor(.black)
                    .offset(y: 3)
            }
        }
        .frame(width: 110, height: 135)
    }
}

#Preview {
    DiaryCardView(dateText: "2025.05.01", emotionImageName: "joy")
}

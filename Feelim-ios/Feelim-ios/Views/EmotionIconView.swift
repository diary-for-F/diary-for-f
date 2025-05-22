//
//  EmotionIconView.swift
//  Feelim-ios
//
//  Created by 김동인 on 5/19/25.
//
import SwiftUI

struct EmotionIconView: View {
    let emotionImageName: String // "happy", "sad" 등 이미지 이름

    var body: some View {
        ZStack {
            // 클립 효과 배경
            Circle()
                .fill(Color.white)
                .frame(width: 34, height: 34)
                .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 1)

            // 배경 원 (이전 색상 기반은 제거)
            Circle()
                .fill(Color.white.opacity(0.3))
                .frame(width: 30, height: 30)
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 1.5)
                )

            // 감정 이모티콘 이미지
            Image(emotionImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)

            // 클립 윗부분 반짝임 효과
            Circle()
                .fill(Color.white.opacity(0.6))
                .frame(width: 7, height: 7)
                .offset(x: -8, y: -8)

            // 클립 뒷부분 살짝 보이게
            Path { path in
                let radius: CGFloat = 17
                path.addArc(center: CGPoint(x: 0, y: 2), radius: radius, startAngle: .degrees(220), endAngle: .degrees(320), clockwise: false)
            }
            .stroke(Color.gray.opacity(0.5), lineWidth: 2)
            .frame(width: 30, height: 6)
            .offset(y: -15)
            .opacity(0.7)
        }
        .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 1)
    }
}

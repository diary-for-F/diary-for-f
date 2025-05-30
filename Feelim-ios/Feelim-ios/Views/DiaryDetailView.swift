//
//  DiaryDetailView.swift
//  Feelim-ios
//
//  Created by 김동인 on 5/29/25.
//

import Foundation
import SwiftUI

struct DiaryDetailView: View {
    let entry: DiaryEntry
    @Environment(\.presentationMode) private var presentationMode
    
    // 뒤집힘 상태
    @State private var isFlipped: Bool = false

    var body: some View {
        ZStack {
            // 앞면
            frontView
                .opacity(isFlipped ? 0 : 1)
                .rotation3DEffect(
                    .degrees(isFlipped ? 180 : 0),
                    axis: (x: 0, y: -1, z: 0), // y : flip 방향
                    perspective: 0.5
                )

            // 뒷면
            backView
                .opacity(isFlipped ? 1 : 0)
                .rotation3DEffect(
                    .degrees(isFlipped ? 360 : 180),
                    axis: (x: 0, y: -1, z: 0), // y : flip 방향
                    perspective: 0.5
                )
        }
        .frame(width: 393, height: 629)
        .animation(.easeInOut(duration: 0.6), value: isFlipped)
        .onTapGesture {
            isFlipped.toggle()
        }
    }
    
    // 앞면: 사용자 일기 조회
    private var frontView: some View {
        ZStack {
            Color.clear

            // 바깥 흰색 카드
            Rectangle()
                .fill(Color.white)
                .frame(width: 393, height: 569.6)
                .offset(y: 29.7)
                .shadow(color: Color.black.opacity(0.10), radius: 16.52)

            VStack {
                ZStack {
                    // 안쪽 검은 배경
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: 349, height: 457)
                        .offset(x: -1, y: 6)

                    // 본문 텍스트
                    ScrollView {
                        Text(entry.content)
                            .font(.custom("SF Pro Display", size: 20).weight(.medium))
                            .lineSpacing(29)
                            .italic()
                            .foregroundColor(.white)
                            .padding()
                    }
                    .frame(width: 349, height: 400)
                    .offset(x: -1, y: 30)
                    
                    // 감정 이모지
                    Image(entry.emotionImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                        .offset(y: -260) // 위치 조절
                }
            }
            
            // 타임스탬프
            Text(entry.timestamp)
                .font(.custom("Roboto", size: 15))
                .foregroundColor(.black)
                .offset(x: -1, y: 270)

        }
        .frame(width: 393, height: 629)
    }
    
    // 뒷면: AI 답장 조회
    private var backView: some View {
        ZStack {
            // 흰색 카드
            Rectangle()
                .fill(Color.white)
                .frame(width: 393, height: 569.6)
                .offset(y: 29.7)
                .shadow(color: Color.black.opacity(0.10), radius: 16.52)
            
            // AI 이모지
            Image(entry.aiImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
                .offset(y: -260) // 위치 조절
            
            // AI 답장 본문
            ScrollView {
                Text(entry.aiReply)
                    .font(.custom("SF Pro Display", size: 20).weight(.medium))
                    .lineSpacing(29)
                    .italic(true)
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .padding(.top, 32)
            }
            .frame(width: 349, height: 340)
            .offset(x: -1, y: 30)
            
            // 답장 생성 시점의 타임스탬프
            Text(entry.timestamp)
                .font(.custom("Roboto", size: 15))
                .foregroundColor(.black)
                .offset(x: -1, y: 270)
        }
    }
}

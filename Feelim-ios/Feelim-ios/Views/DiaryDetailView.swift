//
//  DiaryDetailView.swift
//  Feelim-ios
//
//  Created by 김동인 on 5/29/25.
//

import Foundation
import SwiftUI

struct DiaryDetailView: View {
    let diaryId: String
    
    @StateObject private var viewModel = DiaryDetailViewModel()
    
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
        .onAppear {
            // 뷰가 나타나면 API 호출
            Task { await viewModel.loadDetail(id: diaryId) }
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

                    if viewModel.isLoading {
                        // 로딩 중에는 인디케이터
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5)
                            .foregroundColor(.white)
                    } else if let error = viewModel.errorMessage {
                        // 에러가 있으면 에러 메시지 표시
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                    } else {
                        // 성공적으로 로드된 일기 내용
                        ScrollView {
                            Text(viewModel.content)
                                .font(.custom("SF Pro Display", size: 20).weight(.medium))
                                .lineSpacing(29)
                                .italic(true)
                                .foregroundColor(.white)
                                .padding()
                        }
                        .frame(width: 349, height: 400)
                        .offset(x: -1, y: 30)
                        
                        /// 감정 이모지
                        let emoAsset = viewModel.mainEmotion
                        Image(emoAsset)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90, height: 90)
                            .offset(y: -260)
                    }
                }
            }
            
            // 일기 작성 시점 타임스탬프
            if !viewModel.isLoading && viewModel.errorMessage == nil {
                Text("\(viewModel.formattedDate) \(viewModel.formattedTime)")
                    .font(.custom("Roboto", size: 15))
                    .foregroundColor(.black)
                    .offset(x: -1, y: 270)
            }
        }
        .frame(width: 393, height: 629)
    }
    
    // 뒷면: AI 답장 조회
    private var backView: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(width: 393, height: 569.6)
                .offset(y: 29.7)
                .shadow(color: Color.black.opacity(0.10), radius: 16.52)

            // 실제 서버에서 AI 답장을 내려준다면, ViewModel에 `aiReply` 프로퍼티를 추가하고 바인딩하세요.
            // 현재는 placeholder 텍스트만 띄워둡니다.
            ScrollView {
                Text("AI가 생성한 답장 텍스트를 서버에서 받아와 여기에 표시하세요.")
                    .font(.custom("SF Pro Display", size: 20).weight(.medium))
                    .lineSpacing(29)
                    .italic(true)
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .padding(.top, 32)
            }
            .frame(width: 349, height: 340)
            .offset(x: -1, y: 30)

            // AI 답장 생성 시점 타임스탬프: 서버가 내려준 createdAt(유저 일기 생성 시각) 사용
            Text("\(viewModel.formattedDate) \(viewModel.formattedTime)")
                .font(.custom("Roboto", size: 15))
                .foregroundColor(.black)
                .offset(x: -1, y: 270)
        }
    }
}

//
//  DiaryWriteView.swift
//  Feelim-ios
//
//  Created by 김동인 on 6/3/25.
//

import SwiftUI

// 새 일기를 작성하는 모달 뷰
struct DiaryWriteView: View {
    var onStartSave: () -> Void
    var onFinishSave: () -> Void
    var onCancel: () -> Void
    
    @StateObject private var viewModel = DiaryWriteViewModel()

    private let now = Date()
    private let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy.MM.dd"
        return f
    }()
    private let timeFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy.MM.dd HH:mm"
        return f
    }()

    @State private var content: String = ""
    @State private var selectedEmotion: String = "joy"
    private let maxCharacters = 150
    private let emotions = ["sadness", "neutral", "joy", "anger", "fear", "surprise"]

    var body: some View {
        ZStack {
            // 흰색 프레임
            Rectangle()
                .fill(Color.white)
                .frame(width: 340, height: 520)
                .shadow(color: Color.black.opacity(0.10), radius: 16.52)
            
            // 검은색 입력 영역
            Rectangle()
                .fill(Color.black)
                .frame(width: 310, height: 420)
                .offset(x: -1, y: -23.65)
            
            // TextEditor + Placeholder
            ZStack {
                if content.isEmpty {
                    Text("오늘 하루를\n\n한 장의 필름에 담는다면\n\n어떤 모습일까요?\n\n마음에 스친 오늘의 감정을\n\n   조용히 필름 위에 담아보세요.\n\n\n")
                        .font(.custom("Nanum Pen", size: 21).weight(.medium))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.white.opacity(0.5))
                        .padding(.horizontal, 16)
                }
                TextEditor(text: $content)
                    .font(.custom("Nanum Pen", size: 23).weight(.medium))
                    .lineSpacing(10)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 30)
                    .foregroundColor(Color.white)
                    .scrollContentBackground(.hidden) // 이걸 넣어야 입력 창 배경이 사라짐!!
                    .frame(width: 310, height: 380)
                    .offset(x: -1, y: -23.65)
            }
            
            // 글자 수 카운트
            Text("\(content.count)/\(maxCharacters)")
                .font(.custom("Nanum Pen", size: 21))
                .offset(x: 125, y: 165)
                .foregroundColor(Color.white)

            // 감정 선택 스크롤
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 23) {
                    ForEach(emotions, id: \.self) { emo in
                        Image(emo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 70)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(selectedEmotion == emo ? Color.black : Color.clear, lineWidth: 2)
                            )
                            .onTapGesture {
                                selectedEmotion = emo
                            }
                    }
                }
            }
            .frame(width: 310, height: 70)
            .offset(y: 225)
            
            // 취소, 저장 버튼
            HStack(spacing: 20) {
                Button(action: {
                    onCancel()
                }) {
                    Text("취소")
                        .font(.custom("SF Pro Display", size: 16).weight(.bold))
                        .foregroundColor(.white)
                        .frame(width: 150, height: 50)
                        .background(Color.gray)
                        .clipShape(Capsule())
                }
                
                Button(action: {
                    onStartSave()
                    
                    // 서버 호출 비동기로 실행
                    Task {
                        await writeDiaryToServer()
                    }
                }) {
                    Text("저장")
                        .font(.custom("SF Pro Display", size: 16).weight(.bold))
                        .foregroundColor(.black)
                        .frame(width: 150, height: 50)
                        .background(Color.white)
                        .clipShape(Capsule())
                }
            }
            .padding(.bottom, 30)
            .offset(x: 0, y: 350)
        } // ZStack 끝
//        .padding(.top, 20)
        .background(Color.white)
        .frame(width: 360, height: 568.60)
        .onChange(of: content) {
            if content.count > maxCharacters {
                content = String(content.prefix(maxCharacters))
            }
        }
    }
    
    private func writeDiaryToServer() async {
        let selectedEmotionCode = selectedEmotion ?? "joy"

        let emotions = [
            SelectedEmotion(emotion: selectedEmotionCode, level: 80)
        ]

        // 서버 호출
        await viewModel.writeDiary(
            content: content.trimmingCharacters(in: .whitespacesAndNewlines),
            emotions: emotions
        )

        // 서버 응답이 있으면 “저장 완료” 알림 → 홈뷰에서 로딩뷰 닫음
        if viewModel.response != nil {
            onFinishSave()
        }
    }
}

struct DiaryWriteView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryWriteView(
            onStartSave: {
                print("Save started")
            },
            onFinishSave: {
                print("Save finished")
            },
            onCancel: {
                print("Cancelled")
            }
        )
        .previewDevice("iPhone 16 Pro") // 시뮬레이터 디바이스 설정
    }
}


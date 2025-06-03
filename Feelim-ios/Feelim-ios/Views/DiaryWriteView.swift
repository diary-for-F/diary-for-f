//
//  DiaryWriteView.swift
//  Feelim-ios
//
//  Created by 김동인 on 6/3/25.
//

import SwiftUI

// 새 일기를 작성하는 모달 뷰
struct DiaryWriteView: View {
    var onSave: (DiaryEntry) -> Void
    var onCancel: () -> Void

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
    @State private var selectedEmotion: String = "happy"
    private let maxCharacters = 150
    private let emotions = ["sad", "neutral", "happy", "angry", "anxious", "surprised"]

    var body: some View {
        ZStack {
            // 흰색 프레임
            Rectangle()
                .fill(Color.white)
                .frame(width: 394, height: 568.60)
                .shadow(color: Color.black.opacity(0.10), radius: 16.52)
            
            // 검은색 입력 영역
            Rectangle()
                .fill(Color.black)
                .frame(width: 349.89, height: 456.20)
                .offset(x: -1, y: -23.65)
            
            // TextEditor + Placeholder
            ZStack {
                if content.isEmpty {
                    Text("오늘 하루를\n\n한 장의 필름에 담는다면\n\n어떤 모습일까요?\n\n마음에 스친 오늘의 감정들을\n\n   조용히 필름 위에 담아보세요.\n\n\n")
                        .font(.custom("SF Pro Display", size: 18).weight(.medium))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.white.opacity(0.5))
                        .padding(.horizontal, 16)
                }
                TextEditor(text: $content)
                    .font(.custom("SF Pro Display", size: 20).weight(.medium))
                    .lineSpacing(29)
                    .padding(.horizontal, 8)
                    .foregroundColor(Color.white)
                    .scrollContentBackground(.hidden) // 이걸 넣어야 입력 창 배경이 사라짐!!
                    .frame(width: 349.89, height: 400)
                    .offset(x: -1, y: -23.65)
            }
            
            // 글자 수 카운트
            Text("\(content.count)/\(maxCharacters)")
                .font(.custom("Roboto", size: 15))
                .offset(x: 129.50, y: 181.80)
                .foregroundColor(Color.white)

            // 감정 선택 스크롤
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 23) {
                    ForEach(emotions, id: \.self) { emo in
                        Image(emo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 70)
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
                .offset(x: -30)
                .padding(.leading, 16)
            }
            .frame(width: 370, height: 70)
            .offset(y: 245)
            
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
                    let emotionIndex = emotions.firstIndex(of: selectedEmotion) ?? 2
                    let newEntry = DiaryEntry(
                        date: dateFormatter.string(from: now),
                        timestamp: timeFormatter.string(from: now),
                        emotionImageName: emotions[emotionIndex],
                        content: content.trimmingCharacters(in: .whitespacesAndNewlines),
                        aiReply: "",
                        aiImageName: "robot"
                    )
                    onSave(newEntry)
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
        .padding(.top, 20)
        .background(Color.white)
        .frame(width: 394, height: 568.60)
        .onChange(of: content) {
            if content.count > maxCharacters {
                content = String(content.prefix(maxCharacters))
            }
        }
    }
}


struct DiaryWriteView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(red: 0.15, green: 0.15, blue: 0.15).ignoresSafeArea()

            DiaryWriteView(
                onSave: { entry in
                    print("저장된 일기:", entry)
                },
                onCancel: {
                    print("취소됨")
                }
            )
        }
    }
}

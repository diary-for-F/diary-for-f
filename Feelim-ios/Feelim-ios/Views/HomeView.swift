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
            DiaryEntry(
                date: "2025.05.01",
                timestamp: "2025.05.01 18:20",
                emotionImageName: "sad",
                content: """
                            요즘 들어 자꾸 불안한 생각이 머릿속을 맴돌아.  
                            별일 아닌데도 자꾸 최악의 상황을 상상하게 돼.  
                            마음은 조급한데 몸은 아무것도 하기 싫어.
                        """
            ),
            DiaryEntry(
                date: "2025.05.02",
                timestamp: "2025.05.02 09:15",
                emotionImageName: "happy",
                content: """
                            아침에 일찍 일어나서 산책을 다녀왔어.  
                            상쾌한 공기에 기분이 한결 나아졌어.  
                            오늘 하루도 잘 버텨보자!
                         """
            ),
            DiaryEntry(
                date: "2025.05.02",
                timestamp: "2025.05.02 12:30",
                emotionImageName: "neutral",
                content: """
                            점심으로 간단히 샌드위치를 먹었어.  
                            별다른 일 없이 평범한 하루야.  
                            가끔은 이런 게 좋기도 해.
                         """
            ),
            DiaryEntry(
                date: "2025.05.02",
                timestamp: "2025.05.02 15:45",
                emotionImageName: "angry",
                content: """
                            회의에서 의견이 잘 전달되지 않아서 답답했어.  
                            내가 준비한 자료가 빛을 못 보는 기분이야.  
                            조금 화가 났지만, 다음엔 더 잘해야지.
                         """
            ),
            DiaryEntry(
                date: "2025.05.02",
                timestamp: "2025.05.02 20:10",
                emotionImageName: "anxious",
                content: """
                            내일 있을 발표가 자꾸 머릿속에서 떠나지 않아.  
                            준비는 했지만, 혹시 실수할까 걱정이야.  
                            그래도 잘 해낼 수 있을 거야.
                         """
            )
        ],
        [
            DiaryEntry(
                date: "2025.04.25",
                timestamp: "2025.04.25 11:00",
                emotionImageName: "angry",
                content: """
                            교통체증 때문에 약속 시간에 늦었어.  
                            미리 출발했는데도 예상보다 너무 막혔어.  
                            화가 났지만, 어쩔 수 없었어.
                         """
            ),
            DiaryEntry(
                date: "2025.04.26",
                timestamp: "2025.04.26 18:45",
                emotionImageName: "happy",
                content: """
                            오랜만에 친구를 만나 맛있는 저녁을 먹었어.  
                            수다도 떨고 스트레스가 확 풀렸어.  
                            역시 사람 만나는 게 최고야!
                         """
            )
        ],
        [
            DiaryEntry(
                date: "2025.04.28",
                timestamp: "2025.04.28 07:30",
                emotionImageName: "anxious",
                content: """
                            출근길에 지갑을 두고 온 걸 깨달았어.  
                            큰일 날 뻔했지만 다행히 집에 들렀어.  
                            조금 아찔했어.
                         """
            ),
            DiaryEntry(
                date: "2025.04.29",
                timestamp: "2025.04.29 14:20",
                emotionImageName: "happy",
                content: """
                            업무 목표를 하나 완료했어!  
                            스스로 칭찬해주고 싶어.  
                            작은 성취지만 뿌듯해.
                         """
            ),
            DiaryEntry(
                date: "2025.05.02",
                timestamp: "2025.05.02 21:10",
                emotionImageName: "surprised",
                content: """
                            회사에서 갑자기 칭찬 이메일이 왔어.  
                            내 노력을 알아봐 줘서 기분이 좋았어.  
                            뜻밖의 선물이었어.
                         """
            )
        ],
        [
            DiaryEntry(
                date: "2025.05.03",
                timestamp: "2025.05.03 10:00",
                emotionImageName: "neutral",
                content: """
                            오늘은 특별한 일정 없이 집에서 휴식 중이야.  
                            책도 읽고 음악도 들었어.  
                            가끔은 이렇게 쉬는 것도 필요해.
                         """
            ),
            DiaryEntry(
                date: "2025.05.03",
                timestamp: "2025.05.03 19:30",
                emotionImageName: "happy",
                content: """
                            저녁에는 직접 요리를 해봤어.  
                            의외로 맛있게 성공했어!  
                            다음에는 친구들을 초대해야지.
                         """
            )
        ],
        [
            DiaryEntry(
                date: "2025.05.04",
                timestamp: "2025.05.04 08:15",
                emotionImageName: "sad",
                content: """
                            어제 밤에 잠이 잘 안 왔어.  
                            계속 생각이 복잡해서 뒤척였어.  
                            오늘은 일찍 자야겠다.
                         """
            ),
            DiaryEntry(
                date: "2025.05.04",
                timestamp: "2025.05.04 22:00",
                emotionImageName: "surprised",
                content: """
                            침대 정리를 하다가 오래된 사진을 찾았어.  
                            추억이 새록새록 떠올라 놀랐어.  
                            다음에 앨범을 만들어야겠다.
                         """
            )
        ]
    ]
    
    @State private var selectedEntry : DiaryEntry?

    var body: some View {
        
        ZStack {
            // 기본 홈 화면
            Color(red: 0.15, green: 0.15, blue: 0.15)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                // 상단 로고
                HStack {
                    Spacer()
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)
                        .padding(.top, 40)
                    Spacer()
                }

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 64) {
                        ForEach(photoLines.indices, id: \.self) { index in
                            PhotoLineView(entries: photoLines[index]) { entry in
                                selectedEntry = entry
                            }
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
                    // TODO : 새 일기 추가 액션
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
            
            // 특정 일기 조회 모달
            if let entry = selectedEntry {
                // 어두운 배경
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation { selectedEntry = nil }
                    }

                // 일기 상세 뷰
                DiaryDetailView(entry: entry)
                    .frame(width: 350, height: 500)
                    .shadow(color: Color.black.opacity(0.10), radius: 16.52, x: 0, y: 0)
                    .zIndex(1)
                    // 카드 자체 탭은 막아서 배경 탭만 동작하게
                    .onTapGesture { /* 아무 동작 없음 */ }
            }
        }
    }
}

#Preview {
    HomeView()
}

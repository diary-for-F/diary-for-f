//
//  HomeView.swift
//  Feelim-ios
//
//  Created by 김동인 on 5/19/25.
//

import SwiftUI

struct HomeView: View {
    // 여러 줄의 감정 일기들 샘플
    @State private var photoLines: [[DiaryEntry]] = [
        [
            DiaryEntry(
                date: "2025.05.01",
                timestamp: "2025.05.01 18:20",
                emotionImageName: "sad",
                content: """
                    요즘 들어 자꾸 불안한 생각이 머릿속을 맴돌아.  
                    별일 아닌데도 자꾸 최악의 상황을 상상하게 돼.  
                    마음은 조급한데 몸은 아무것도 하기 싫어.
                """,
                aiReply: """
                    지금 느끼는 불안은 당신이 소중한 무언가를 지키고 있다는 증거예요.  
                    오늘도 잘 해냈어요.
                """,
                aiImageName: "robot"
            ),
            DiaryEntry(
                date: "2025.05.02",
                timestamp: "2025.05.02 09:15",
                emotionImageName: "happy",
                content: """
                    아침에 일찍 일어나서 산책을 다녀왔어.  
                    상쾌한 공기에 기분이 한결 나아졌어.  
                    오늘 하루도 잘 버텨보자!
                """,
                aiReply: """
                    아침 산책으로 기분이 좋아졌군요!  
                    이렇게 긍정적인 마음으로 하루를 시작해줘서 고마워요.
                """,
                aiImageName: "robot"
            ),
            DiaryEntry(
                date: "2025.05.02",
                timestamp: "2025.05.02 12:30",
                emotionImageName: "neutral",
                content: """
                    점심으로 간단히 샌드위치를 먹었어.  
                    별다른 일 없이 평범한 하루야.  
                    가끔은 이런 게 좋기도 해.
                """,
                aiReply: """
                    평범한 하루도 소중해요.  
                    가끔은 이런 안정이 필요하답니다.
                """,
                aiImageName: "robot"
            ),
            DiaryEntry(
                date: "2025.05.02",
                timestamp: "2025.05.02 15:45",
                emotionImageName: "angry",
                content: """
                    회의에서 의견이 잘 전달되지 않아서 답답했어.  
                    내가 준비한 자료가 빛을 못 보는 기분이야.  
                    조금 화가 났지만, 다음엔 더 잘해야지.
                """,
                aiReply: """
                    회의에서 답답하셨군요.  
                    다음에는 분명 더 좋은 결과가 있을 거예요.
                """,
                aiImageName: "robot"
            ),
            DiaryEntry(
                date: "2025.05.02",
                timestamp: "2025.05.02 20:10",
                emotionImageName: "anxious",
                content: """
                    내일 있을 발표가 자꾸 머릿속에서 떠나지 않아.  
                    준비는 했지만, 혹시 실수할까 걱정이야.  
                    그래도 잘 해낼 수 있을 거야.
                """,
                aiReply: """
                    발표 준비가 잘 되고 있어요.  
                    자신감을 가져도 좋아요.
                """,
                aiImageName: "robot"
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
                """,
                aiReply: """
                    교통체증은 피할 수 없지만,  
                    침착하게 대처하신 게 멋져요.
                """,
                aiImageName: "robot"
            ),
            DiaryEntry(
                date: "2025.04.26",
                timestamp: "2025.04.26 18:45",
                emotionImageName: "happy",
                content: """
                    오랜만에 친구를 만나 맛있는 저녁을 먹었어.  
                    수다도 떨고 스트레스가 확 풀렸어.  
                    역시 사람 만나는 게 최고야!
                """,
                aiReply: """
                    친구와의 시간으로 스트레스를 풀었네요.  
                    훌륭해요.
                """,
                aiImageName: "robot"
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
                """,
                aiReply: """
                    지갑을 잃어버렸지만 잘 대처하셨군요.  
                    침착함이 큰 힘을 발휘했어요.
                """,
                aiImageName: "robot"
            ),
            DiaryEntry(
                date: "2025.04.29",
                timestamp: "2025.04.29 14:20",
                emotionImageName: "happy",
                content: """
                    업무 목표를 하나 완료했어!  
                    스스로 칭찬해주고 싶어.  
                    작은 성취지만 뿌듯해.
                """,
                aiReply: """
                    목표 달성 축하드려요!  
                    작은 성취가 모여 큰 성취가 됩니다.
                """,
                aiImageName: "robot"
            ),
            DiaryEntry(
                date: "2025.05.02",
                timestamp: "2025.05.02 21:10",
                emotionImageName: "surprised",
                content: """
                    회사에서 갑자기 칭찬 이메일이 왔어.  
                    내 노력을 알아봐 줘서 기분이 좋았어.  
                    뜻밖의 선물이었어.
                """,
                aiReply: """
                    뜻밖의 칭찬이라니 정말 기분 좋으셨겠어요!  
                    계속 힘내세요.
                """,
                aiImageName: "robot"
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
                """,
                aiReply: """
                    집에서 휴식을 취하며 재충전하셨군요.  
                    휴식도 중요한 시간이에요.
                """,
                aiImageName: "robot"
            ),
            DiaryEntry(
                date: "2025.05.03",
                timestamp: "2025.05.03 19:30",
                emotionImageName: "happy",
                content: """
                    저녁에는 직접 요리를 해봤어.  
                    의외로 맛있게 성공했어!  
                    다음에는 친구들을 초대해야지.
                """,
                aiReply: """
                    직접 요리에 성공하셨다니 멋져요!  
                    다음엔 친구들과 나누어 보세요.
                """,
                aiImageName: "robot"
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
                """,
                aiReply: """
                    잠이 안 오셨다니 힘드셨겠어요.  
                    오늘은 편안하게 쉬세요.
                """,
                aiImageName: "robot"
            ),
            DiaryEntry(
                date: "2025.05.04",
                timestamp: "2025.05.04 22:00",
                emotionImageName: "surprised",
                content: """
                    침대 정리를 하다가 오래된 사진을 찾았어.  
                    추억이 새록새록 떠올라 놀랐어.  
                    다음에 앨범을 만들어야겠다.
                """,
                aiReply: """
                    오래된 사진으로 소중한 추억을 되새기셨군요.  
                    좋은 시간이었다면 정말 다행이에요.
                """,
                aiImageName: "robot"
            )
        ]
    ]

    
    // 특정 일기 선택 여부
    @State private var selectedEntry : DiaryEntry?
    
    // 새 일기 작성 화면 표시 여부
    @State private var isPresentingWriteView = false
    
    // 로딩 화면 표시 여부
    @State private var isPresentingDevelopingView = false

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

                // 일기 목록
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 64) {
                        ForEach(photoLines.indices, id: \.self) { index in
                            PhotoLineView(entries: photoLines[index]) { entry in
                                // 클릭된 일기 선택
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
                    isPresentingWriteView = true
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
            
            // 일기 작성 모달
            if isPresentingWriteView {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isPresentingWriteView = false
                    }
                DiaryWriteView(
                    onSave: { newEntry in
                        if photoLines.isEmpty {
                            photoLines = [[newEntry]]
                        } else {
                            photoLines[0].insert(newEntry, at: 0)
                        }
                        isPresentingWriteView = false
                        isPresentingDevelopingView = true
                        
                        // (임시) 로딩 7초 후 자동 닫기
                        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                            isPresentingDevelopingView = false
                        }
                    }
                    , onCancel: {
                        isPresentingWriteView = false
                    }
                )
                .frame(width: 394, height: 568.60)
                .shadow(color: Color.black.opacity(0.1), radius: 16, x: 0, y: 0)
                .zIndex(1)
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
        
        // 로딩 화면 모달
        .fullScreenCover(isPresented: $isPresentingDevelopingView) {
            DevelopingView()
        }
        
    }
}

#Preview {
    HomeView()
}

//
//  HomeView.swift
//  Feelim-ios
//
//  Created by 김동인 on 5/19/25.
//

import SwiftUI

struct HomeView: View {
    // 작성된 일기 조회
    @StateObject private var viewModel = DiaryListViewModel()
    
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
                        PhotoLineView(entries: viewModel.diaryEntries) { entry in
                            selectedEntry = entry
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
                    onStartSave: {
                        // 로딩화면 띄우기
                        DispatchQueue.main.async {
                            isPresentingWriteView = false
                            isPresentingDevelopingView = true
                        }
                    },
                    onFinishSave: {
                        // 다시 전체 일기 불러오기 + 로딩화면 닫기
                        Task { @MainActor in
                            await viewModel.loadDiaries()
                            isPresentingDevelopingView = false
                        }
                    },
                    onCancel: {
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
        // 로딩 화면 표시
        .fullScreenCover(isPresented: $isPresentingDevelopingView) {
            DevelopingView()
        }
         // 전체 일기 조회 API 호출
        .task {
            await viewModel.loadDiaries()
        }
    }
}

#Preview {
    HomeView()
}

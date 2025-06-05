//
//  DiaryListViewModel.swift
//  Feelim-ios
//
//  Created by 김동인 on 6/4/25.
//

import Foundation

// View와 Networking을 연결하는 중간 관리자 (데이터 준비와 변환)
class DiaryListViewModel: ObservableObject {
    @Published var diaryEntries: [DiaryEntry] = []
    
    func loadDiaries() async {
        do {
            // TODO : 무한 스크롤 구현
            let dtos = try await APIClient.shared.fetchDiaries(page: 1, limit: 30)
            let entries = dtos.map { dto -> DiaryEntry in
                DiaryEntry(
                    id: String(dto.id),
                    date: String(dto.createdAt.prefix(10)),
                    timestamp: dto.createdAt,
                    emotionImageName: dto.mainEmotion,
                    content: dto.content,
                    aiReply: "",
                    aiImageName: "robot"
                )
            }
            DispatchQueue.main.async {
                self.diaryEntries = entries
            }
        } catch {
            print("Error loading diaries: \(error)")
        }
    }
}

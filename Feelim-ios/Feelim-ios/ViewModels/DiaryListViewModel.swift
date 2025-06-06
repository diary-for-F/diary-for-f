//
//  DiaryListViewModel.swift
//  Feelim-ios
//
//  Created by 김동인 on 6/4/25.
//

import Foundation

// View와 Networking을 연결하는 중간 관리자 (데이터 준비와 변환)
class DiaryListViewModel: ObservableObject {
    // 주차별 일기
    @Published var groupedDiaryEntries: [(weekOfYear: Int, entries: [DiaryEntry])] = []
    
    func loadDiaries() async {
        do {
            // TODO : 무한 스크롤 구현
            let dtos = try await APIClient.shared.fetchDiaries(page: 1, limit: 100)
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
            // 주차 기준으로 그룹핑
            let calendar = Calendar.current
            let groupedDict = Dictionary(grouping: entries) { entry -> Int in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let date = dateFormatter.date(from: entry.timestamp) ?? Date()
                return calendar.component(.weekOfYear, from: date)
            }
            
            // 최신 주차 기준으로 정렬
            let sortedGroups = groupedDict.map { (week, entries) in
                let sortedEntries = entries.sorted { $0.timestamp > $1.timestamp }
                return (weekOfYear: week, entries: sortedEntries)
            }
                .sorted { $0.weekOfYear > $1.weekOfYear }
            
            DispatchQueue.main.async {
                self.groupedDiaryEntries = sortedGroups
            }
        } catch {
            print("Error loading diaries: \(error)")
        }
    }
}

//
//  DiaryDetailViewModel.swift
//  Feelim-ios
//
//  Created by 김동인 on 6/5/25.
//

import Foundation

// 일기 상세 정보를 받아와서 View에 바인딩해 주는 ViewModel
@MainActor
class DiaryDetailViewModel: ObservableObject {
    @Published var content: String = ""
    @Published var mainEmotion: String = ""
    @Published var createdAt: Date = Date()

    @Published var aiReply: String = ""
    @Published var aiCreatedAt: Date = Date()
    
    @Published var isLoading: Bool = false
    @Published var isLoadingAI: Bool = false
    @Published var errorMessage: String? = nil
    @Published var aiErrorMessage: String? = nil
    
    /// 서버의 "2025-06-04T18:16:27" 형식을 파싱할 포맷터
    private let serverDateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        f.locale = Locale(identifier: "en_US_POSIX")
        return f
    }()
    
    /// AI 피드백에서 주는 "yyyy-MM-dd HH:mm:ss" 형식을  파싱할 포맷터
    private let aiDateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd HH:mm:ss"
        f.locale = Locale(identifier: "en_US_POSIX")
        return f
    }()

    /// 화면에 보여줄 포맷터
    private let displayDateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy.MM.dd"
        return f
    }()
    private let displayTimeFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        return f
    }()

    
    // 서버에서 받아온 DTO를 화면에 쓰기 쉬운 모델로 변환해 주도록 확장 가능
    func loadDetail(id: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let dto = try await APIClient.shared.fetchDiaryDetail(id: id)
            // 받아온 데이터를 바로 Published 프로퍼티에 할당
            content = dto.content
            mainEmotion = dto.mainEmotion
            // "2025-06-04T18:16:27" 을 Date로 수동 변환
            if let parsed = serverDateFormatter.date(from: dto.createdAt) {
                createdAt = parsed
            } else {
                // 파싱 실패 시 기본값 유지 혹은 에러 처리
                print("⚠️ createdAt 파싱 실패: \(dto.createdAt)")
                createdAt = Date()
            }
        } catch {
            errorMessage = error.localizedDescription
            print("❌ 일기 상세 오류: \(error)")
        }
    }
    
    /// AI 답변과 생성 시각 받기
    func loadAIFeedback(id: String) async {
        isLoadingAI = true
        defer { isLoadingAI = false }

        do {
            let dto = try await APIClient.shared.fetchAIFeedback(id: id)
            aiReply = dto.ai_feedback
            // "2025-06-04 12:44:53" 문자열 → Date로 변환
            if let parsed = aiDateFormatter.date(from: dto.created_at) {
                aiCreatedAt = parsed
            } else {
                print("AI created_at 파싱 실패: \(dto.created_at)")
                aiCreatedAt = Date()
            }
        } catch {
            aiErrorMessage = error.localizedDescription
            print("AI 피드백 조회 오류: \(error)")
        }
    }
  
    /// “yyyy.MM.dd” 형식으로 포맷팅된 문자열
    var formattedDate: String {
        displayDateFormatter.string(from: createdAt)
    }

    /// "HH:mm" 형식으로 포맷팅된 문자열
    var formattedTime: String {
        displayTimeFormatter.string(from: createdAt)
    }
    
    /// AI createdAt을 "yyyy.MM.dd" 형식 문자열로 반환
    var formattedAIDate: String {
        displayDateFormatter.string(from: aiCreatedAt)
    }

    /// AI createdAt을 "HH:mm" 형식 문자열로 반환
    var formattedAITime: String {
        displayTimeFormatter.string(from: aiCreatedAt)
    }
}

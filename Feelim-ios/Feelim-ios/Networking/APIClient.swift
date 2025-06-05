//
//  APIClient.swift
//  Feelim-ios
//
//  Created by 김동인 on 6/4/25.
//

import Foundation

// 서버와 통신하는 네트워크 클라이언트
class APIClient {
    static let shared = APIClient()
    private init() {}
    
    private let baseURL = "https://1fed05tpvg.execute-api.ap-northeast-2.amazonaws.com/prod"
    
    // 전체 일기 조회
    func fetchDiaries(page: Int, limit: Int) async throws -> [DiaryDTO] {
        let urlString = "\(baseURL)/diaries?page=\(page)&limit=\(limit)"
        print("API 호출 URL: \(urlString)")
        
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decodedResponse = try JSONDecoder().decode([DiaryDTO].self, from: data)
        print("디코딩 성공, 데이터 수: \(decodedResponse.count)")

        return decodedResponse
    }
    
    // 일기 작성
    func postDiary(request: DiaryWriteRequest) async throws -> DiaryWriteResponse {
        let urlString = "\(baseURL)/diary"
        print("API 호출 URL: \(urlString)")

        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .withoutEscapingSlashes
        let requestBody = try encoder.encode(request)
        urlRequest.httpBody = requestBody
        
        if let jsonString = String(data: requestBody, encoding: .utf8) {
            print("최종 전송 바디: \(jsonString)")
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                let responseBody = String(data: data, encoding: .utf8) ?? "(응답 body 파싱 실패)"
                print("서버 오류 발생 - 상태코드: \(httpResponse.statusCode)")
                print("서버 응답 내용: \(responseBody)")
                throw NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "서버 오류: \(httpResponse.statusCode)"])
            }
            
            let decodedResponse = try JSONDecoder().decode(DiaryWriteResponse.self, from: data)
            print("디코딩 성공, 응답 데이터 : \(decodedResponse)")
            
            return decodedResponse
            
        } catch {
            print("요청 중 에러 발생: \(error)")
            throw error
        }
    }
    
    // 특정 일기 상세 조회
    func fetchDiaryDetail(id: String) async throws -> DiaryDetailResponse {
        let urlString = "\(baseURL)/diary?id=\(id)"
        print("일기 상세 API 호출 URL: \(urlString)")
        
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            let responseBody = String(data: data, encoding: .utf8) ?? "(응답 body 파싱 실패)"
            print("일기 상세 조회 서버 오류 - 상태코드: \( (response as? HTTPURLResponse)?.statusCode ?? -1 )")
            print("서버 응답 내용: \(responseBody)")
            throw NSError(domain: "", code: (response as? HTTPURLResponse)?.statusCode ?? -1,
                          userInfo: [NSLocalizedDescriptionKey: "일기 상세 조회 중 서버 오류: \( (response as? HTTPURLResponse)?.statusCode ?? -1 )"])
        }
                
        let detailDTO = try JSONDecoder().decode(DiaryDetailResponse.self, from: data)
        print("일기 상세 디코딩 성공: \(detailDTO)")
        return detailDTO
    }
    
    // 특정 일기 AI 답변 조회
        func fetchAIFeedback(id: String) async throws -> DiaryAIFeedbackResponse {
            let urlString = "\(baseURL)/ai-feedback?id=\(id)"
            
            guard let url = URL(string: urlString) else {
                throw URLError(.badURL)
            }

            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let bodyString = String(data: data, encoding: .utf8) ?? "(응답 body 파싱 실패)"
                print("[AI 피드백 조회] 서버 오류 상태코드: \((response as? HTTPURLResponse)?.statusCode ?? -1)")
                print("서버 응답 내용: \(bodyString)")
                throw URLError(.badServerResponse)
            }

            let decoder = JSONDecoder()
            let aiResponse = try decoder.decode(DiaryAIFeedbackResponse.self, from: data)
            print("[AI 피드백 조회] 디코딩 성공: \(aiResponse)")
            
            return aiResponse
        }
    }

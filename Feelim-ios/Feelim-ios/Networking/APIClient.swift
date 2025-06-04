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
    
    func fetchDiaries(page: Int, limit: Int) async throws -> [DiaryDTO] {
        let urlString = "\(baseURL)/api/get-diary-list?page=\(page)&limit=\(limit)"
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
}

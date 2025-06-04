//
//  DiaryResponse.swift
//  Feelim-ios
//
//  Created by 김동인 on 6/4/25.
//

import Foundation

// JSON 응답 매핑 모델
struct DiaryResponse: Codable {
    let statusCode: Int
    let body: [DiaryDTO]
}

struct DiaryDTO: Codable {
    let id: Int
    let content: String
    let mainEmotion: String
    let createdAt: String
}

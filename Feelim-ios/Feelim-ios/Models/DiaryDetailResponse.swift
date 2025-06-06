//
//  DiaryDetailResponse.swift
//  Feelim-ios
//
//  Created by 김동인 on 6/5/25.
//

// DiaryDetailDTO.swift
import Foundation

struct DiaryDetailResponse: Codable {
    let id: String
    let content: String
    let mainEmotion: String
    let createdAt: String
}

//
//  DiaryWriteResponse.swift
//  Feelim-ios
//
//  Created by 김동인 on 6/5/25.
//

import Foundation

struct DiaryWriteResponse: Codable {
    let id: Int
    let topEmotions: [TopEmotion]
    let message: String
}

struct TopEmotion: Codable {
    let emotion: String
    let score: Int
}

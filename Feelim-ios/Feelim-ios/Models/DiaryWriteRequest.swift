//
//  DiaryWriteRequest.swift
//  Feelim-ios
//
//  Created by 김동인 on 6/5/25.
//

import Foundation

struct DiaryWriteRequest: Codable {
    let content: String
    let selectedEmotions: [SelectedEmotion]
}

struct SelectedEmotion: Codable {
    let emotion: String
    let level: Int
}

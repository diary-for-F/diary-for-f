//
//  DiaryEntry.swift
//  Feelim-ios
//
//  Created by 김동인 on 5/19/25.
//

import SwiftUI

struct DiaryEntry: Identifiable {
    var id: String
    let date: String               // ex. "2025.05.01"
    let timestamp: String          // ex. "2025.05.01 18:20"
    let emotionImageName: String   // ex. "sadness", "joy"…
    let content: String            // 일기 본문
    
    // AI 답장용 필드
    let aiReply: String
    let aiImageName: String        // "robot"
    
    // 기본 생성자
    init(
        id: String = "",
        date: String,
        timestamp: String,
        emotionImageName: String,
        content: String,
        aiReply: String,
        aiImageName: String
    ) {
        self.id = id
        self.date = date
        self.timestamp = timestamp
        self.emotionImageName = emotionImageName
        self.content = content
        self.aiReply = aiReply
        self.aiImageName = aiImageName
    }
    
    // 새로운 일기 생성 시 사용
    init(
        date: String,
        timestamp: String,
        emotionImageName: String,
        content: String
    ) {
        self.id = ""
        self.date = date
        self.timestamp = timestamp
        self.emotionImageName = emotionImageName
        self.content = content
        self.aiReply = ""         // 아직 AI 답장은 비어 있음
        self.aiImageName = ""     // 나중에 채워질 수 있도록 빈 문자열
    }
}

//
//  DiaryEntry.swift
//  Feelim-ios
//
//  Created by 김동인 on 5/19/25.
//

import SwiftUI

struct DiaryEntry: Identifiable {
    let id = UUID()
    let date: String               // ex. "2025.05.01"
    let timestamp: String          // ex. "2025.05.01 18:20"
    let emotionImageName: String   // ex. "sad", "happy"…
    let content: String            // 일기 본문
    
    // AI 답장용 필드
    let aiReply: String
    let aiImageName: String        // "robot"
}

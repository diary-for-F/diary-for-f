//
//  DiaryEntry.swift
//  Feelim-ios
//
//  Created by 김동인 on 5/19/25.
//

import SwiftUI

struct DiaryEntry: Identifiable, Hashable {
    let id = UUID()
    let date: String
    let emotionImageName: String // "happy", "sad", ...
}

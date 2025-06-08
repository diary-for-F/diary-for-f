//
//  DiaryWriteViewModel.swift
//  Feelim-ios
//
//  Created by 김동인 on 6/5/25.
//

import Foundation

class DiaryWriteViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var response: DiaryWriteResponse? = nil
    @Published var errorMessage: String? = nil
    
    func writeDiary(content: String, emotions: [SelectedEmotion]) async {
        await MainActor.run { self.isLoading = true }
        
        let request = DiaryWriteRequest(content: content, selectedEmotions: emotions)
        
        do {
            let result = try await APIClient.shared.postDiary(request: request)
            await MainActor.run {
                self.response = result
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
        
        await MainActor.run { self.isLoading = false }
    }
}


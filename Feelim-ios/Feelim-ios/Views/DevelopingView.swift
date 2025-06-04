//
//  DevelopingView.swift
//  Feelim-ios
//
//  Created by 김동인 on 6/4/25.
//

import SwiftUI

struct DevelopingView: View {
    
    @State private var photoStep: Int = 0
    private let totalSteps = 4
    private let maxOffset: CGFloat = -60
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color(red: 0.15, green: 0.15, blue: 0.15).ignoresSafeArea()
            
            VStack(spacing: 50) {
                ZStack {
                    // 카메라 고정 배경
                    Image("cameraImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 300)
                        .overlay(
                            Image("photoImage")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 240, height: 240)
                                .offset(y: -70 + calculatePhotoOffset())
                            , alignment: .top
                        )
                }
                
                // 텍스트와 점 로딩
                VStack(spacing: 10) {
                    Text("사진을 인화하는 중입니다.\n\n")
                        .foregroundColor(.white)
                        .font(Font.custom("Arial", size: 20))
                    
                    HStack(spacing: 8) {
                        ForEach(0..<totalSteps, id: \.self) { index in
                            Circle()
                                .fill(index == photoStep % totalSteps ? Color.white : Color.gray)
                                .frame(width: 10, height: 10)
                        }
                    }
                }
            }
        }
        .onReceive(timer) { _ in
            updateAnimationStep()
        }
    }
    
    // 사진 offset 계산
    private func calculatePhotoOffset() -> CGFloat {
        let offsetPerStep = maxOffset / CGFloat(totalSteps)
        return offsetPerStep * CGFloat(photoStep)
    }
    
    // 매 타이머 tick마다 step 증가
    private func updateAnimationStep() {
        photoStep = (photoStep + 1) % totalSteps
    }
}

#Preview {
    DevelopingView()
}

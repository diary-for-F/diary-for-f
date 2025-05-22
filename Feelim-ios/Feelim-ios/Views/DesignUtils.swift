import SwiftUI

// 스크롤 위치를 추적하기 위한 PreferenceKey
struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// 곡선 모양 줄 생성을 위한 구조체
struct CurvedLine: Shape {
    let width: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // 전체 화면 영역을 벗어나는 줄을 만들기 위해 좌우로 더 확장
        // 왼쪽 끝 시작점 (화면보다 넓게)
        path.move(to: CGPoint(x: -100, y: 0))
        
        // 2차 곡선으로 가운데가 내려간 곡선 생성 (더 깊게)
        path.addQuadCurve(
            to: CGPoint(x: width + 100, y: 0), // 오른쪽도 화면 영역 밖으로 연장
            control: CGPoint(x: width/2, y: 60) // 더 깊게 내려가게 조정
        )
        
        return path
    }
} 
//
//  ThreeSegmentView.swift
//  Main
//
//  Created by Christian Wilkins on 9/28/24.
//
import SwiftUI

// usage:
// @State private var progress: Double = 0.0
// ThreeSegmentLoadingBar(progress: progress)

// advance progress
//withAnimation(.easeInOut(duration: 0.5)) {
//    if progress < 1.0 {
//        progress += 1.0 / 3.0
//    } else {
//        progress = 0.0 // Reset after completion
//    }
//}

struct ThreeSegmentLoadingBar: View {
    var progress: Double // Range: 0.0 to 1.0
    var spacing: CGFloat = 8
    var segmentColor: Color = .green
    var backgroundColor: Color = Color.gray.opacity(0.3)

    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<3) { index in
                Rectangle()
                    .fill(self.segmentFill(for: index))
                    .frame(maxWidth: .infinity)
                    .frame(height: 20)
                    .cornerRadius(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
        }
        .padding(.horizontal)
    }

    private func segmentFill(for index: Int) -> Color {
        let thresholds = [1.0 / 3.0, 2.0 / 3.0, 1.0]
        return progress >= thresholds[index] ? segmentColor : backgroundColor
    }
}

import SwiftUI

struct ThreeSegmentLoadingBar: View {
    @Binding var progress: Double
    var spacing: CGFloat = 8
    var segmentColor: Color = .green
    var backgroundColor: Color = Color.gray.opacity(0.3)

    @Binding var shouldShimmer: Bool
    @State private var shimmerOffset: CGFloat = -1.0

    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<3) { index in
                ZStack {
                    // Display rectangle with proper fill based on progress
                    Rectangle()
                        .fill(self.segmentFill(for: index))
                        .frame(maxWidth: .infinity)
                        .frame(height: 20)
                        .cornerRadius(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.gray, lineWidth: 1)
                        )

                    // Show shimmer effect for the active rectangle
                    if self.shouldShimmer(for: index) {
                        shimmerView()
                            .frame(height: 20)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                }
            }
        }
        .padding(.horizontal)
        .onChange(of: shouldShimmer) { newValue in
            if newValue {
                shimmerOffset = -1.0
                startShimmering()
            }
        }
        .onChange(of: progress) { newProgress in
            if shouldShimmer {
                shimmerOffset = -1.0
                startShimmering()
            }
        }
    }

    private func threshold(for index: Int) -> Double {
        let thresholds = [1.0 / 3.0, 2.0 / 3.0, 1.0]
        return thresholds[index]
    }

    private func segmentFill(for index: Int) -> Color {
        return progress >= threshold(for: index) ? segmentColor : backgroundColor
    }

    private func shouldShimmer(for index: Int) -> Bool {
        let thresholds = [1.0 / 3.0, 2.0 / 3.0, 1.0]
        if index == 0 && progress < thresholds[index] {
            return true
        }
        if index == 1 && progress >= thresholds[index - 1] && progress < thresholds[index] {
            return true
        }
        if index == 2 && progress >= thresholds[index - 1] && progress < 1.0 {
            return true
        }
        return false
    }

    private func shimmerView() -> some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            LinearGradient(
                gradient: Gradient(colors: [Color.green.opacity(0.4), Color.green.opacity(0.7), Color.green.opacity(0.4)]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(width: width * 0.5, height: 20)
            .offset(x: shimmerOffset * width)
        }
    }

    private func startShimmering() {
        shimmerOffset = -1.0 // Reset the offset
        withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
            shimmerOffset = 1.5
        }
    }
    }


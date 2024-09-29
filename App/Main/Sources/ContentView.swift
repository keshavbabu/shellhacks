import SwiftUI
import MapKit

public struct ContentView: View {
    @Environment(UserViewModel.self) var userViewModel: UserViewModel
    @State private var isPresented: Bool = true
    @State private var progress: Double = 0
    @State private var shimmerShouldStart = false

    public init() {}

    public var body: some View {
        VStack {
            if let user = userViewModel.userData {
                if user.status == .evacuate {
                    EvacView()
                } else {
                    MapView(userState: user.status)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            isPresented = true
                        }
                        .sheet(isPresented: $isPresented, onDismiss: {
                            shimmerShouldStart = false
                        }) {
                            VStack {
                                ThreeSegmentLoadingBar(progress: $progress, shouldShimmer: $shimmerShouldStart)
                                    .padding(.top)
                                    .onAppear {
                                        if let status = userViewModel.userData?.status {
                                            triggerShimmer(for: status)
                                        }
                                    }
                                    .onChange(of: userViewModel.userData?.status) { newStatus in
                                        if let status = newStatus {
                                            triggerShimmer(for: status)
                                        }
                                    }

                                if let status = userViewModel.userData?.status {
                                    switch status {
                                    case .collaborating:
                                        CollabView()
                                            .padding()
                                            .presentationDetents([.fraction(0.40)])
                                    case .whipping:
                                        WhipView()
                                            .padding()
                                            .presentationDetents([.fraction(0.40)])
                                    case .scooping:
                                        ScoopView()
                                            .padding()
                                            .presentationDetents([.fraction(0.50)])
                                    default:
                                        EmptyView()
                                    }
                                } else {
                                    EmptyView()
                                }

                                Spacer()
                            }
                            .padding()
                        }

                }
            } else {
                Text("Loading user data...")
            }
        }
        .onAppear {
            userViewModel.fetchUsers()
        }
    }

    private func triggerShimmer(for status: EvacuateState) {
        // Reset shimmer state
        shimmerShouldStart = false
        
        withAnimation(.easeInOut(duration: 0.5)) {
            switch status {
            case .collaborating:
                progress = 1.0 / 3.0
            case .whipping:
                progress = 2.0 / 3.0
            case .scooping:
                progress = 3.0 / 3.0
            default:
                progress = 0.0
            }
        }
        shimmerShouldStart = true
    }

}

import SwiftUI
import MapKit

public struct ContentView: View {
    @Environment(UserViewModel.self) var userViewModel: UserViewModel
    @State private var isPresented: Bool = true
    @State private var progress: Double = 1.0
    
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
                        .sheet(isPresented: $isPresented) {
                            VStack() {
                                ThreeSegmentLoadingBar(progress: progress)
                                switch user.status {
                                case .collaborating:
                                    CollabView().presentationDetents([.fraction(0.40)])
                                        .onAppear {
                                            withAnimation(.easeInOut(duration: 0.5)) {
                                                if progress < 1.0 {
                                                    progress += 1.0 / 3.0
                                                } else {
                                                    progress = 0.0 // Reset after completion
                                                }
                                            }
                                        }
                                case .whipping:
                                    WhipView().presentationDetents([.fraction(0.40)])
                                        .onAppear {
                                            withAnimation(.easeInOut(duration: 0.5)) {
                                                if progress < 1.0 {
                                                    progress += 1.0 / 3.0
                                                } else {
                                                    progress = 0.0 // Reset after completion
                                                }
                                            }
                                        }
                                case .scooping:
                                    ScoopView().presentationDetents([.fraction(0.40)])
                                        .onAppear {
                                            withAnimation(.easeInOut(duration: 0.5)) {
                                                if progress < 1.0 {
                                                    progress += 1.0 / 3.0
                                                } else {
                                                    progress = 0.0 // Reset after completion
                                                }
                                            }
                                        }
                                default:
                                    EmptyView()
                            }
                            }
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
}

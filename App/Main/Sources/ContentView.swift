import SwiftUI
import MapKit

public struct ContentView: View {
    @Environment(UserViewModel.self) var userViewModel: UserViewModel
    @State private var isPresented: Bool = true
    @State private var progress: Double = 0
    
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
                                    CollabView().padding().presentationDetents([.fraction(0.40)])
                                        .onAppear {
                                            withAnimation(.easeInOut(duration: 0.5)) {
                                                progress = 1.0 / 3.0
                                            }
                                        }
                                case .whipping:
                                    WhipView().padding().presentationDetents([.fraction(0.40)])
                                        .onAppear {
                                            withAnimation(.easeInOut(duration: 0.5)) {
                                                progress = 2.0 / 3.0
                                            }
                                        }
                                case .scooping:
                                    ScoopView().padding().presentationDetents([.fraction(0.40)])
                                        .onAppear {
                                            withAnimation(.easeInOut(duration: 0.5)) {
                                                progress = 3.0 / 3.0
                                            }
                                        }
                                default:
                                    EmptyView()
                            }
                                Spacer()
                            }.padding()
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

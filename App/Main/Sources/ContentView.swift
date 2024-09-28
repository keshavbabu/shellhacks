import SwiftUI
import MapKit

public struct ContentView: View {
    @Environment(UserViewModel.self) var userViewModel: UserViewModel
    @State private var isPresented: Bool = true
    
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
                            switch user.status {
                            case .collaborating:
                                CollabView().presentationDetents([.fraction(0.40)])
                            case .whipping:
                                WhipView().presentationDetents([.fraction(0.40)])
                            case .scooping:
                                ScoopView().presentationDetents([.fraction(0.40)])
                            default:
                                EmptyView()
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

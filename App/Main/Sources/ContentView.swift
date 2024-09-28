//
//  ContentView.swift
//  Shellhacks
//
//  Created by Keshav Babu on 9/27/24.
//
import SwiftUI
import MapKit

public struct ContentView: View {
    @Environment(UserViewModel.self) var userViewModel: UserViewModel
    public init() {}
    
    public var body: some View {
        VStack {
            if let user = userViewModel.userData {
                switch user.status {
                case .evacuate:
                    EvacView()
                case .collaborating:
                    CollabView()
                case .whipping:
                    WhipView()
                case .scooping:
                    ScoopView()
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

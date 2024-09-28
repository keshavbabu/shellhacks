//
//  ContentView.swift
//  Shellhacks
//
//  Created by Keshav Babu on 9/27/24.
//
import SwiftUI
import MapKit

public struct ContentView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    public var body: some View {
        VStack {
            if let user = userViewModel.userData {
                switch EvacuateState(rawValue: user.state) {
                case .evacuate:
                    EvacView()
                case .collaborating:
                    CollabView()
                case .whipping:
                    WhipView()
                case .scooping:
                    ScoopView()
                default:
                    Text("Unknown state")
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

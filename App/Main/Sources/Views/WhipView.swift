//
//  WhipView.swift
//  Main
//
//  Created by Shaheer Khan on 9/28/24.
//
import SwiftUI
struct WhipView: View {
    @Environment(UserViewModel.self) var userViewModel: UserViewModel
    @State var Friends: [Evacuee] = []
    
    var body: some View {
        VStack {
            ProgressView()
            Text("Finding Whip...").font(.title).bold()
//                List {
//                    ForEach(Friends) { friend in
//                        Text(friend.name)
//                    }
//                }
        }
        .padding()
        .onAppear {
            userViewModel.fetchUsers()
        }
    }
    
}

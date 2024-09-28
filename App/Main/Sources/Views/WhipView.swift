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
        VStack(spacing: 2) {
            Text("Finding Whip...")
                .font(.title)
                .bold()
                .padding()
            
            Text("Evacuees 🏃‍♂️")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .font(.title2)
            
            List {
                ForEach(Friends) { friend in
                    Text(friend.name)
                }
            }
            .listStyle(PlainListStyle())
            .padding(.top, 0)
        }
        .onAppear {
            userViewModel.fetchUsers()
            if let user = userViewModel.userData {
                let friends = user.group
                for friend in friends ?? [] {
                    Friends.append(friend)
                }
            }
        }
    }
}

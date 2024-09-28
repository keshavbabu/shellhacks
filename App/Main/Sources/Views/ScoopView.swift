//
//  ScoopView.swift
//  Main
//
//  Created by Shaheer Khan on 9/28/24.
//

import SwiftUI

struct ScoopView: View {
    @Environment(UserViewModel.self) var userViewModel: UserViewModel
    @State private var pickedUpFriends: [Evacuee] = []
    @State private var waitingFriends: [Evacuee] = []

    var body: some View {
        VStack(spacing: 0) {
            if let user = userViewModel.userData {
                if let timeLeft = user.timeToPickUp {
                    Text("Be Ready in \(timeLeft) minutes")
                        .bold()
                        .font(.headline)
                        .padding()
                }
                List {
                    if !pickedUpFriends.isEmpty {
                        Section(header: Text("Picked Up")) {
                            ForEach(pickedUpFriends) { friend in
                                HStack {
                                    AsyncImage(url: URL(string: friend.pfp)) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                                .frame(width: 75, height: 90)
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .frame(width: 75, height: 90)
                                                .clipShape(Circle())
                                        case .failure:
                                            Image(systemName: "photo")
                                                .font(.largeTitle)
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                    .padding()
                                    Text(friend.name)
                                }
                            }
                        }
                    }

                    if !waitingFriends.isEmpty {
                        Section(header: Text("Waiting")) {
                            ForEach(waitingFriends) { friend in
                                HStack {
                                    AsyncImage(url: URL(string: friend.pfp)) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                                .frame(width: 75, height: 90)
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .frame(width: 75, height: 90)
                                                .clipShape(Circle())
                                        case .failure:
                                            Image(systemName: "photo")
                                                .font(.largeTitle)
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                    .padding()
                                    Text(friend.name)
                                }
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .onAppear {
            userViewModel.fetchUsers()
            if let user = userViewModel.userData {
                let friends = user.group ?? []
                let pickedUpIds = user.pickedUp ?? []
                pickedUpFriends = friends.filter { pickedUpIds.contains($0.id) }
                waitingFriends = friends.filter { !pickedUpIds.contains($0.id) }
            }
        }
    }
}

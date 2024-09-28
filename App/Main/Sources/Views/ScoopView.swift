//
//  WhipView.swift
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
                        .font(.title3)
                        .padding(.vertical, 16)
                }
                Divider()
                List {
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
                            .padding(.trailing, 16)
                            VStack(alignment: .leading) {
                                Text(friend.name)
                                    .font(.title3)
                                    .bold()
                                Text("Picked Up")
                                    .foregroundColor(.green)
                                    .font(.subheadline)
                            }
                        }
                        .padding(.vertical, 8)
                    }

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
                            .padding(.trailing, 16) 
                            VStack(alignment: .leading) {
                                Text(friend.name)
                                    .font(.title3)
                                    .bold()
                                Text("Waiting")
                                    .foregroundColor(.red)
                                    .font(.subheadline)
                            }
                        }
                        .padding(.vertical, 8)
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

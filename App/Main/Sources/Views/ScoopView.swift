//
//  WhipView.swift
//  Main
//
//  Created by Shaheer Khan on 9/28/24.
//
import SwiftUI
struct ScoopView: View {
    @Environment(UserViewModel.self) var userViewModel: UserViewModel
    
    var pickedUpFriends: [Evacuee] {
        userViewModel.userData?.group?.filter({ e in
            userViewModel.userData?.pickedUp?.contains(e.id) ?? false
        }) ?? []
    }
    
    var waitingFriends: [Evacuee] {
        userViewModel.userData?.group?.filter({ e in
            !(userViewModel.userData?.pickedUp?.contains(e.id) ?? false)
        }) ?? []
    }

    var body: some View {
        VStack {
            if let user = userViewModel.userData {
                if let timeLeft = user.timeToPickUp {
                    if timeLeft > 0 {
                        Text("Be Ready in \(timeLeft) minutes")
                            .bold()
                            .font(.title3)
                    } else {
                        Text("Driver is here. Stay Safe.")
                            .bold()
                            .font(.title3)
                    }
                }
                Divider()
                List {
                    ForEach(pickedUpFriends) { friend in
                        HStack {
                            AsyncImage(url: URL(string: friend.pfp)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 50, height: 50)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                case .failure:
                                    Image(systemName: "photo")
                                        .font(.largeTitle)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            
                            VStack(alignment: .leading) {
                                Text(friend.name)
                                    .font(.title3)
                                    .bold()
                                Text("Picked Up")
                                    .foregroundColor(.green)
                                    .font(.subheadline)
                            }
                        }
                        
                    }

                    ForEach(waitingFriends) { friend in
                        HStack {
                            AsyncImage(url: URL(string: friend.pfp)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 50, height: 50)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                case .failure:
                                    Image(systemName: "photo")
                                        .font(.largeTitle)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                           
                            VStack(alignment: .leading) {
                                Text(friend.name)
                                    .font(.title3)
                                    .bold()
                                Text("Waiting")
                                    .foregroundColor(.red)
                                    .font(.subheadline)
                            }
                        }
                        
                    }
                }
                .listStyle(PlainListStyle())
                .onChange(of: userViewModel.userData?.pickedUp) { _ in
                    print("userViewModel.userData change")
                    print(userViewModel.userData?.pickedUp)
                   
                }
            }
        }
    }
}

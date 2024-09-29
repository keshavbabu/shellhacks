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
        VStack() {
            Text("Finding a Driver...")
                .font(.title)
                .bold()
            
            Text("Evacuees 🏃‍♂️")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title2)
            Divider()
            List {
                ForEach(Friends) { friend in
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
            .listStyle(PlainListStyle())
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

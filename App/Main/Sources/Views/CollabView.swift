//
//  CollabView.swift
//  Main
//
//  Created by Shaheer Khan on 9/28/24.
//
import SwiftUI
import MapKit

struct CollabView: View {
    @Environment(UserViewModel.self) var userViewModel: UserViewModel
    var body: some View {
        VStack {
            Text("Finding other Evacuees...")
                .font(.title)
                .bold()
                .padding()
            Spacer()
        }
    }
}

#Preview {
    CollabView()
}

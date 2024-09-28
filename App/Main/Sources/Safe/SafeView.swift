//
//  SafeView.swift
//  Main
//
//  Created by Shaheer Khan on 9/28/24.
//
import MapKit
import SwiftUI

struct SafeView: View {
    var body: some View {
        Map().blur(radius: 10)
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.gray)
            .shadow(color: .green, radius: 10, x: 0, y: 10)
            .frame(width: 300, height: 150)
    }
}

#Preview {
    SafeView()
}

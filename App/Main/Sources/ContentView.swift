//
//  ContentView.swift
//  Shellhacks
//
//  Created by Keshav Babu on 9/27/24.
//

import SwiftUI

public struct ContentView: View {
    public init() {}
    public var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

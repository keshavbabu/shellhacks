//
//  ContentView.swift
//  Shellhacks
//
//  Created by Keshav Babu on 9/27/24.
//

import SwiftUI

public struct ContentView: View {
    @State var vm = POIViewModel()
    public init() {}
    public var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(vm.hurricaine?.hurricaine.rawValue.description ?? "bruh")
        }
        .padding()
        .onAppear {
            vm.fetchData()
        }
    }
}

#Preview {
    ContentView()
}

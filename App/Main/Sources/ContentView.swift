//
//  ContentView.swift
//  Shellhacks
//
//  Created by Keshav Babu on 9/27/24.
//

import SwiftUI
import MapKit

public struct ContentView: View {
    @State var vm = POIViewModel()
    
    public init() {}
    
    public var body: some View {
        Map {
            // stuff in here will be dependant on the state
        }
        .overlay {
            // stuff in here will be dependant on the state
        }
        .overlay(alignment: .top) {
            
        }
        .ignoresSafeArea()
        .onAppear {
            vm.fetchData()
        }
    }
}

#Preview {
    ContentView()
}

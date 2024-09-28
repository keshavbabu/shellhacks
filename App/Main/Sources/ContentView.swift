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
        Group {
            if let hurricaine = vm.hurricaine {
                Group {
                    Map {
                        // stuff in here will be dependant on the state
                    }
                    .overlay {
                        // stuff in here will be dependant on the state
                    }
                }
            }
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

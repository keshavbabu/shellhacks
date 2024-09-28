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
        Group {
            if let hurricaine = vm.hurricaine {
                Group {
                    switch hurricaine.hurricaine {
                    case .none:
                        SafeView()
                    case .incoming:
                        WarningView()
                    case .here:
                        DangerView()
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

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
    
    var statusText: String {
        guard let hurricane = vm.hurricaine else {
            return ""
        }
        switch hurricane.hurricaine {
        case .here:
            return "DANGER"
        case .incoming:
            return "WARNING"
        case .none:
            return "SAFE"
        }
    }
    
    var statusTextColor: Color {
        guard let hurricane = vm.hurricaine else {
            return .clear
        }
        switch hurricane.hurricaine {
        case .here:
            return .red
        case .incoming:
            return .yellow
        case .none:
            return .green
        }
    }
    
    public var body: some View {
        Map {
            // stuff in here will be dependant on the state
        }
        .ignoresSafeArea()
        .overlay {
            // stuff in here will be dependant on the state
        }
        .overlay(alignment: .top) {
            HStack {
                Text(statusText)
                  .fontWeight(.black)
                  .foregroundStyle(statusTextColor)
                  .padding(10)
                  .background(RoundedRectangle(cornerRadius: 12).fill(Color(UIColor.systemGray5)))
                  .padding()
                Spacer()
                if let hurricaine = vm.hurricaine {
                    switch hurricaine.hurricaine {
                    case .none:
                        EmptyView()
                    case .incoming, .here:
                        Text("10 mi")
                          .fontWeight(.black)
                          .foregroundStyle(statusTextColor)
                          .padding(10)
                          .background(RoundedRectangle(cornerRadius: 12).fill(Color(UIColor.systemGray5)))
                          .padding()
                    }
                }
            }
        }
        .onAppear {
            vm.fetchData()
        }
    }
}

#Preview {
    ContentView()
}

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
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)

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
    
    var blurRadius: CGFloat {
        if vm.hurricaine?.hurricaine == .some(.none) {
            return 10
        }
        return 0
    }
    
    public var body: some View {
        Map(position: $cameraPosition) {
                    ForEach(vm.poi, id: \.name) { poi in
                        Annotation(poi.name, coordinate: CLLocationCoordinate2D(latitude: poi.coordinates.latitude, longitude: poi.coordinates.longitude)) {
                            VStack {
                                Image(systemName: "mappin.circle.fill")
                                    .foregroundStyle(.red)
                                    .font(.title)
                                Text(poi.name)
                                    .font(.caption)
                                    .foregroundColor(.primary)
                            }
                            .onAppear {
                                print("Appearing \(poi.name)")
                            }
                        }
                        
                    }
                }
        .blur(radius: blurRadius)
        .ignoresSafeArea()
        .overlay {
            // stuff in here will be dependant on the state
            if vm.hurricaine?.hurricaine == .some(.none) {
                            Text("For more information visit https://www.nhc.noaa.gov/")
                              .fontWeight(.black)
                              .foregroundStyle(statusTextColor)
                              .padding(10)
                              .background(RoundedRectangle(cornerRadius: 12).fill(Color(UIColor.darkGray)))
                              .padding()
                        }
        }
        .overlay(alignment: .top) {
            HStack {
                Text(statusText)
                  .fontWeight(.black)
                  .foregroundStyle(statusTextColor)
                  .padding(10)
                  .background(RoundedRectangle(cornerRadius: 12).fill(Color(UIColor.darkGray)))
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
                          .background(RoundedRectangle(cornerRadius: 12).fill(Color(UIColor.darkGray)))
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

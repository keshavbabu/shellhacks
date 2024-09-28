//
//  ContentView.swift
//  Shellhacks
//
//  Created by Keshav Babu on 9/27/24.
//

import SwiftUI
import MapKit

public struct ContentView: View {
    @Environment(DeeplinkRouter.self) var deeplinkRouter: DeeplinkRouter
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
        @Bindable var deeplink = self.deeplinkRouter
        
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
        .mapControls {
            MapUserLocationButton()
                .controlSize(.large)
        }
        .blur(radius: blurRadius)
        .overlay {
            if vm.hurricaine?.hurricaine == .some(.none) {
                Text("For more information visit https://www.nhc.noaa.gov/")
                    .fontWeight(.black)
                    .foregroundStyle(statusTextColor)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(UIColor.darkGray)))
                    .padding()
            }
        }
        .overlay(alignment: .bottomTrailing) {
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
                        if let location = vm.location, let hurricaneCoordinates = vm.hurricaine?.eye {
                            let userLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
                            let hurricaneLocation = CLLocation(latitude: hurricaneCoordinates.latitude, longitude: hurricaneCoordinates.longitude)
                            let distanceInMeters = userLocation.distance(from: hurricaneLocation)
                            let distanceInMiles = distanceInMeters / 1609.344
                            Text(String(format: "%.2f mi", distanceInMiles))
                                .fontWeight(.black)
                                .foregroundStyle(statusTextColor)
                                .padding(10)
                                .background(RoundedRectangle(cornerRadius: 12).fill(Color(UIColor.darkGray)))
                                .padding()
                        }
                    }
                }
            }
        }
        .onAppear {
            vm.fetchData()
        }
        .sheet(isPresented: $deeplink.notificationTapped) {
            if let location = vm.location {
                NavigationSheet(location: location, poi: vm.poi)
                    .presentationDetents([.medium])
            } else {
                ProgressView()
            }
        }
    }
}

//#Preview {
//    ContentView()
//}

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
    @State private var showSheet: Bool = false
    @Namespace var mapScope
    
    @State var showingNav = false
    @State var selectedPOI: POI?
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
    
    let coordinates = [
        // 20.037856104272088, -83.56012446431905
        CLLocationCoordinate2D(latitude: 20.037856104272088, longitude: -83.56012446431905),
        // 22.280120247380523, -86.07927628636105
        CLLocationCoordinate2D(latitude: 22.280120247380523, longitude: -86.07927628636105),
        // 30.392561226076666, -84.29560885292774
        CLLocationCoordinate2D(latitude: 30.392561226076666, longitude: -84.29560885292774),
        // 32.88289565183958, -84.09229534686774
        CLLocationCoordinate2D(latitude: 32.88289565183958, longitude: -84.09229534686774)
    ]

    let gradient = LinearGradient(colors: [.red, .green, .blue], startPoint: .leading, endPoint: .trailing)

    let stroke = StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round, dash: [10, 10])
    
    public var body: some View {
        @Bindable var deeplink = self.deeplinkRouter
        Map(position: $cameraPosition, scope: mapScope) {
            MapPolyline(coordinates: coordinates, contourStyle: .geodesic)
                .stroke(gradient, style: stroke)
            ForEach(vm.poi, id: \.name) { poi in
                Annotation(poi.name, coordinate: CLLocationCoordinate2D(latitude: poi.coordinates.latitude, longitude: poi.coordinates.longitude)) {
                    VStack {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundStyle(statusTextColor)
                            .font(.title)
                            .onTapGesture {
                                selectedPOI = poi
                                }
                    }
                    .onAppear {
                        print("Appearing \(poi.name)")
                    }
                }
                
            }
            
        }
        
        .overlay(alignment: .bottomTrailing) {
            HStack {
                Spacer()
                MapUserLocationButton(scope: mapScope)
            }
            .padding()
        }
        .mapScope(mapScope)
        .blur(radius: blurRadius)
        .overlay {
            if vm.hurricaine?.hurricaine == .some(.none) {
                Text("For more information visit https://www.nhc.noaa.gov/")
                    .fontWeight(.black)
                    .foregroundStyle(statusTextColor)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(UIColor.systemGray5)))
                    .padding()
            }
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
                        if let location = vm.location, let hurricaneCoordinates = vm.hurricaine?.eye {
                            let userLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
                            let hurricaneLocation = CLLocation(latitude: hurricaneCoordinates.latitude, longitude: hurricaneCoordinates.longitude)
                            let distanceInMeters = userLocation.distance(from: hurricaneLocation)
                            let distanceInMiles = distanceInMeters / 1609.344
                            Text(String(format: "%.2f mi", distanceInMiles))
                                .fontWeight(.black)
                                .foregroundStyle(statusTextColor)
                                .padding(10)
                                .background(RoundedRectangle(cornerRadius: 12).fill(Color(UIColor.systemGray5)))
                                .padding()
                        }
                    }
                }
            }
        }
        .onAppear {
            vm.fetchData()
            if deeplink.notificationTapped {
                withAnimation(.easeIn(duration: 1.0)) {
                    showingNav = true
                }
            }
        }
        .sheet(isPresented: $showingNav) {
            if let location = vm.location, !vm.poi.isEmpty {
                NavigationSheet(location: location, poi: vm.poi)
                    .presentationDetents([.fraction(0.33)])
            } else {
                ProgressView()
            }
        }
        .sheet(item: $selectedPOI) { poi in
            if let location = vm.location {
                let coordinates = Coordinates(latitude: location.latitude, longitude: location.longitude)
                POIDetailSheet(location: coordinates, poi: [poi])
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

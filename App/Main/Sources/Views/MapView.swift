//
//  MapView.swift
//  Main
//
//  Created by Shaheer Khan on 9/28/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    var user: Main.User
    @Environment(UserViewModel.self) var userviewModel
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @Namespace var mapScope
    
    var body: some View {
        Map(position: $cameraPosition, scope: mapScope) {
            if let users = user.group {
                ForEach(users) { e in
                    Annotation(e.name, coordinate: e.coordinates.toCLLocationCoordinates()) {
                        ZStack {
                            Circle()
                                .fill(.white)
                                .frame(width: 40, height: 40)
                            Circle()
                                .fill(user.pickedUp?.contains(e.id) == true ? .green : .red)
                                .frame(width: 30, height: 30)
                        }
                    }
                }
                if let location = userviewModel.location {
                    Annotation("Me", coordinate: location.toCLLocationCoordinates()) {
                        ZStack {
                            Circle()
                                .fill(.white)
                                .frame(width: 40, height: 40)
                            Circle()
                                .fill(user.pickedUp?.contains(user.id!) == true ? .green : .blue)
                                .frame(width: 30, height: 30)
                        }
                    }
                }
                
            }
            
        }
        .onChange(of: user.group, { oldValue, newValue in
            var locations: [Coordinates] = []
            if let location = userviewModel.location {
                locations.append(location)
            }
            
            if let group = newValue {
                for evac in group {
                    locations.append(evac.coordinates)
                }
            }
            
            if locations.isEmpty { return }
            
            let x = locations.map(\.latitude).reduce(0) { partialResult, c in
                return partialResult + c
            } / Double(locations.count)
            
            let y = locations.map(\.longitude).reduce(0) { partialResult, c in
                return partialResult + c
            } / Double(locations.count)
            
            let minX = locations.map(\.latitude).min() ?? 0
            let maxX = locations.map(\.latitude).max() ?? 0
            
            let minY = locations.map(\.longitude).min() ?? 0
            let maxY = locations.map(\.longitude).max() ?? 0
            
            withAnimation(.easeInOut(duration: 10)) {
                cameraPosition = .region(.init(center: .init(latitude: x - 0.005, longitude: y), latitudinalMeters: (maxY - minY) * 100000 * 2, longitudinalMeters: (maxX - minX) * 100000 * 2))
            }
        })
        .overlay(alignment: .topTrailing) {
                    HStack {
                        Spacer()
                        MapUserLocationButton(scope: mapScope)
                    }
                    .padding()
                    .safeAreaPadding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
                }
                .mapScope(mapScope)
                
    }
}

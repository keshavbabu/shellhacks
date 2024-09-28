//
//  NavigationSheet.swift
//  Main
//
//  Created by Keshav Babu on 9/28/24.
//

import SwiftUI
import CoreLocation

public struct NavigationSheet: View {
    @State var coordinates: Coordinates? = nil
    let location: Coordinates
    let poi: [POI]
    
    public var body: some View {
        if let coordinates = coordinates {
            Text("This sheet will ask if the user wants to start navigation: \(location) \n \(poi)")
            
            Button("Start Navigation") {
                let url = URL(string: "maps://?saddr=&daddr=\(coordinates.latitude),\(coordinates.longitude)")
                if let url = url, UIApplication.shared.canOpenURL(url) {
                  UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        } else {
            ProgressView()
                .onAppear {
                    var minDistance = Double.greatestFiniteMagnitude
                    var finalCoords : Coordinates?
                    for point in poi {
                        let currCoords = CLLocation(latitude: point.coordinates.latitude, longitude: point.coordinates.longitude)
                        let distance = currCoords.distance(from: CLLocation(latitude: location.latitude, longitude: location.longitude))
                        if distance < minDistance {
                            minDistance = distance
                            finalCoords = point.coordinates
                        }
                    }
                    coordinates = finalCoords
                }
        }
        
    }
}

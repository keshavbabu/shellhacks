//
//  POIDetailSheet.swift
//  Main
//
//  Created by Shaheer Khan on 9/28/24.
//

import SwiftUI
import CoreLocation
public struct POIDetailSheet: View {
    @State var poig: POI? = nil
    let location: Coordinates
    let poi: [POI]
    
    public var body: some View {
        VStack(alignment: .leading) {
            if let nearestPOI = poig {
                Text("\(nearestPOI.name)").font(.title).bold().multilineTextAlignment(.center)
                Spacer()
                Text("Address: \(nearestPOI.address)").font(.subheadline).fontWeight(.light)
                Text("Accommodations: ")
                ForEach(nearestPOI.extra, id: \.self) { item in
                    HStack {
                        switch item {
                        case .petFriendly:
                            Image(systemName: "dog.fill")
                        }
                        Text(item.rawValue)
                    }
                }
                Spacer()
                HStack {
                    Spacer()
                    Button("Start Navigation") {
                        let url = URL(string: "maps://?saddr=&daddr=\(nearestPOI.coordinates.latitude),\(nearestPOI.coordinates.longitude)")
                        if let url = url, UIApplication.shared.canOpenURL(url) {
                          UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .fontWeight(.black)
                    Spacer()
                }
    //            .foregroundStyle(statusTextColor)
            } else {
                ProgressView()
                    .onAppear {
                        var minDistance = Double.greatestFiniteMagnitude
                        var finalPOI : POI?
                        for point in poi {
                            let currCoords = CLLocation(latitude: point.coordinates.latitude, longitude: point.coordinates.longitude)
                            let distance = currCoords.distance(from: CLLocation(latitude: location.latitude, longitude: location.longitude))
                            if distance < minDistance {
                                minDistance = distance
                                finalPOI = point
                            }
                        }
                        poig = finalPOI
                    }
            }
        }
        .padding()
    }
}

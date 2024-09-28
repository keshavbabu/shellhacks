//
//  NavigationSheet.swift
//  Main
//
//  Created by Keshav Babu on 9/28/24.
//

import SwiftUI
import CoreLocation

public struct NavigationSheet: View {
    @State var poig: POI? = nil
    let location: Coordinates
    let poi: [POI]
    
    public var body: some View {
        VStack(alignment: .leading) {
            if let nearestPOI = poig {
//                Spacer()
                Text("Evacuate Now").font(.title).bold().multilineTextAlignment(.center)
                Text("Address: \(nearestPOI.address)").font(.subheadline).bold().multilineTextAlignment(.center)
                    .onAppear {
                        print("extra: \(nearestPOI.extra)")
                        for item in nearestPOI.extra {
                            print("extra: \(item)")
                        }
                    }
                Text("Nearest Shelter").font(.subheadline).fontWeight(.light)
                Text("Special Accommodations: ")
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
                .foregroundStyle(.white)
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
        .fontWeight(.black)
        .foregroundStyle(.white)
        .background(Color(UIColor.systemGray5))
                .multilineTextAlignment(.center)
        
    }
}

//
//  MapView.swift
//  Main
//
//  Created by Shaheer Khan on 9/28/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    var userState: EvacuateState
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    var body: some View {
        Map(coordinateRegion: $region)
    }
}

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
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @Namespace var mapScope
    var body: some View {
        Map(position: $cameraPosition, scope: mapScope) {
               }
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

//
//  SwiftUIView.swift
//  Main
//
//  Created by Shaheer Khan on 9/28/24.
//

import SwiftUI
import MapKit
struct MapView: View {
    var body: some View {
        Map(interactionModes: [.rotate, .zoom])
    }
}

#Preview {
    MapView()
}

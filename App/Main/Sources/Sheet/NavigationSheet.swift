//
//  NavigationSheet.swift
//  Main
//
//  Created by Keshav Babu on 9/28/24.
//

import SwiftUI

public struct NavigationSheet: View {
    let location: Coordinates
    let poi: [POI]
    public var body: some View {
        Text("This sheet will ask if the user wants to start navigation: \(location) \n \(poi)")
    }
}

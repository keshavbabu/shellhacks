//
//  UserViewModel.swift
//  Main
//
//  Created by Shaheer Khan on 9/28/24.
//

import FirebaseFirestore
import SwiftUI
import Observation
import MapKit
import Foundation

enum EvacuateState: Int, Codable {
    case evacuate = 0
    case collaborating = 1
    case whipping = 2
    case scooping = 3
}

class User: Codable {
    let name: String
    let id: String
    let state: Int
    let pfp: String
    
    init( name: String, state: Int, pfp: String, id: String) {
        self.name = name
        self.id = id
        self.state = state
        self.pfp = pfp
    }
}

class UserViewModel: ObservableObject {
    @Published var userData: User? = nil
    func fetchUsers() {
        
    }
}

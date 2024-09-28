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

struct Coordinates: Decodable {
    let latitude: Double
    let longitude: Double
}

struct Evacuee: Decodable, Identifiable {
    let id: String
    let name: String
    let pfp: String
    let coordinates: Coordinates
}

struct User: Decodable {
    @DocumentID var id: String?
    var name: String
    var status: EvacuateState
    var pfp: String
    
    // this will only be there when status is 2 or 3
    var group: [Evacuee]?
    
    // this will only be there when status is 3
    var pickedUp: [String]?
    
    // this will only be there when status is 3
    var timeToPickUp: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case pfp
        case group
        case pickedUp = "picked_up"
        case timeToPickUp = "time_to_pick_up"
    }
}
@Observable
public class UserViewModel: ObservableObject {
    public init() {}
    var userData: User? = nil
    public func fetchUsers() {
        Firestore.firestore().collection("users").document("Dq7BnKSxkF34duMPHNb4").addSnapshotListener { snapshot, error in
            if let snapshot = snapshot {
                let user = try! snapshot.data(as: User.self)
                self.userData = user
            }
        }
        
    }
}

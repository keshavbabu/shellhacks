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

//struct Constants {
//    static let userID = "Tyyp0mAmn9tzaKFhTSxo"
//}

enum EvacuateState: Int, Codable {
    case evacuate = 0
    case collaborating = 1
    case whipping = 2
    case scooping = 3
}

struct Coordinates: Decodable, Equatable {
    let latitude: Double
    let longitude: Double
    
    func toCLLocationCoordinates() -> CLLocationCoordinate2D {
        print("coords: \(self.latitude) \(self.longitude)")
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}

struct Evacuee: Decodable, Identifiable, Equatable {
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
public class UserViewModel: NSObject, CLLocationManagerDelegate {
    var userID: String
    public init(userID: String) {
        self.userID = userID
        print(userID)
    }
    var userData: User? = nil
    var location: Coordinates? = nil
    private let manager = CLLocationManager()
    public func fetchUsers() {
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        Firestore.firestore().collection("users").document(userID).addSnapshotListener { snapshot, error in
            if let snapshot = snapshot {
                do {
                     let user = try snapshot.data(as: User.self)
                     self.userData = user
                 } catch {
                     print("error: \(error)")
                 }
            }
        }
        
    }
    // Location manager shit
    public func locationManager(
            _ manager: CLLocationManager,
            didUpdateLocations locations: [CLLocation]
        ) {
            print("bruh; \(locations)")
            if let location = locations.last {
                self.location = Coordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            }
        }
        
        public func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
            print("bruh: \(error)")
        }
        
        public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .restricted,.denied,.notDetermined:
                print("failed")
            default:
                manager.startUpdatingLocation()
            }
        }
}

//
//  POIViewModel.swift
//  Main
//
//  Created by Keshav Babu on 9/28/24.
//

import FirebaseFirestore
import SwiftUI
import Observation
import MapKit

enum Hurricaine: Int, Codable {
    case none = 0
    case incoming = 1
    case here = 2
}

struct HurricaineDoc: Codable {
    var hurricaine: Hurricaine
    var eye: Coordinates
}

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
}

enum Status: Int, Codable {
    case closed = 0
    case preparing = 1
    case open = 2
}

struct POI: Codable {
    let address: String
    let name: String
    let coordinates: Coordinates
    let status: Status
    let medicalEquipment: [String]
    
    enum CodingKeys: String, CodingKey {
        case address
        case name
        case coordinates
        case status
        case medicalEquipment = "medical_equipment"
    }
}

@Observable
class POIViewModel: NSObject, CLLocationManagerDelegate {
    var hurricaine: HurricaineDoc? = nil
    var poi: [POI] = []
    var location: Coordinates? = nil
    private let manager = CLLocationManager()
    
    func fetchData() {
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        Firestore.firestore().collection("0").document("0")
            .addSnapshotListener { snapshot, error in
                guard let snapshot = snapshot else {
                    print("snpashot error: \(error)")
                    return
                }
                let doc = Result {
                    try snapshot.data(as: HurricaineDoc.self)
                }
                
                switch doc {
                case .success(let doc):
                    self.hurricaine = doc
                case .failure(let error):
                    print("decoding error: \(error)")
                }
            }
        
        Firestore.firestore().collection("poi").addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else {
                print("snapshot error: \(error)")
                return
            }
            
            self.poi = snapshot.documents.compactMap { s in
                let r = Result {
                    try s.data(as: POI.self)
                }
                
                switch r {
                case .success(let poi):
                    return poi
                case .failure(let error):
                    return nil
                }
            }
            print("good: \(self.poi.count)")
        }
        
    }
    
    // Location manager shit
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        print("bruh; \(locations)")
        if let location = locations.last {
            self.location = Coordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("bruh: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted,.denied,.notDetermined:
            print("failed")
        default:
            manager.startUpdatingLocation()
        }
    }
}

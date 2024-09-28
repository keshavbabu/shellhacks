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
}

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
}

struct POI: Codable {
    let address: String
    let name: String
    let coordinates: Coordinates
}

@Observable
class POIViewModel {
    var hurricaine: HurricaineDoc? = nil
    var poi: [POI] = []
    private let manager = CLLocationManager()
    
    func fetchData() {
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
            
            let poi = snapshot.documents.compactMap { s in
                let r = Result {
                    try s.data(as: POI.self)
                }
                
                switch r {
                case .success(let poi):
                    return poi
                case .failure(let error):
                    print(error)
                    return nil
                }
            }
            print(poi)
        }
        
    }
}

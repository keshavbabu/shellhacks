//
//  POIViewModel.swift
//  Main
//
//  Created by Keshav Babu on 9/28/24.
//

import FirebaseFirestore
import SwiftUI
import Observation

enum Hurricaine: Int, Codable {
    case none = 0
    case incoming = 1
    case here = 2
}

struct HurricaineDoc: Codable {
    var hurricaine: Hurricaine
}

@Observable
class POIViewModel {
    var hurricaine: HurricaineDoc? = nil
    func fetchData() {
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
    }
}

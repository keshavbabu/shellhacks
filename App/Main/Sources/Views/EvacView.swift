//
//  EvacView.swift
//  Main
//
//  Created by Shaheer Khan on 9/28/24.
//
import SwiftUI
import MapKit

struct EvacView: View {
    
    @Environment(UserViewModel.self) var userViewModel: UserViewModel
    var body: some View {
        Map().blur(radius: 10)
        .overlay(
            ZStack{
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(UIColor.systemGray5))
                    .shadow(color: .black, radius: 10, x: 0, y: 10)
                    .frame(width: 300, height: 100);
                Text("Evacuate")
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.red)
            }
                .onAppear {
                    userViewModel.fetchUsers()
                    print("Lat: \(userViewModel.location?.latitude ?? 0), Long: \(userViewModel.location?.longitude ?? 0)")
                }
        ) .onTapGesture {
            // keshav code
            guard let url = URL(string: "https://shellhacks.keshavbabu.com") else {
                print("Invalid URL")
                return
            }

            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
            let json: [String: Any] = [
                "user_id": "Dq7BnKSxkF34duMPHNb4",
                "coordinates": [
                    "longitude": userViewModel.location?.longitude,
                    "latitude": userViewModel.location?.latitude
                ]
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                request.httpBody = jsonData
            } catch {
                print("Failed to serialize JSON: \(error.localizedDescription)")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    return
                }
                
                do {
                    if let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print(responseJSON)
                    }
                } catch {
                    print("Failed to parse JSON: \(error.localizedDescription)")
                }
            }
            
            task.resume()
        }
    }
}

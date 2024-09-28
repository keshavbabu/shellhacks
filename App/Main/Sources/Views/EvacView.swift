//
//  EvacView.swift
//  Main
//
//  Created by Shaheer Khan on 9/28/24.
//
import SwiftUI
import MapKit

struct EvacView: View {
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
        ).onTapGesture {
            // keshav code
            
        }
        
//        func buttonAction(){
//            userActivity(String, collaborating)
//        }
    }
}

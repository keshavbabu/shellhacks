//
//  ShellhacksApp.swift
//  Shellhacks
//
//  Created by Keshav Babu on 9/27/24.
//

import SwiftUI
import Main

@main
struct ShellhacksApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State var deeplinkRouter = DeeplinkRouter()
    @State var userViewModel = UserViewModel()
    init() {
        delegate.deeplinkRouter = deeplinkRouter
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(deeplinkRouter)
                .environment(userViewModel)
        }
    }
}

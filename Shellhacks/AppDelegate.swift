//
//  AppDelegate.swift
//  Main
//
//  Created by Keshav Babu on 9/28/24.
//

import FirebaseCore
import SwiftUI
import FirebaseMessaging
import Main

class AppDelegate: NSObject, UIApplicationDelegate {
    public var deeplinkRouter: DeeplinkRouter?
    
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
    FirebaseApp.configure()
    
    // messaging bs
    Messaging.messaging().delegate = self

    UNUserNotificationCenter.current().delegate = self

    let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
    UNUserNotificationCenter.current().requestAuthorization(
      options: authOptions,
      completionHandler: { _, _ in }
    )

    application.registerForRemoteNotifications()
      
    return true
  }
}

extension AppDelegate: MessagingDelegate {
    func messaging(
        _ messaging: Messaging,
        didReceiveRegistrationToken fcmToken: String?
    ) {
        print("registration token: \(fcmToken)")
        Messaging.messaging().subscribe(toTopic: "weather") { error in
            print("Subscribed to weather topic: \(error)")
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // This is called on notification received
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .badge, .sound, .list])
    }
    
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        Messaging.messaging().setAPNSToken(deviceToken, type: .unknown)
    }
    
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        print("notif: \(response)")
        deeplinkRouter?.notificationTapped = true
        // deep linking here when a notification is tapped
        completionHandler()
    }
}

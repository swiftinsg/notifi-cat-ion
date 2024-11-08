//
//  notifi_cat_ionApp.swift
//  notifi-cat-ion
//
//  Created by Jia Chen Yee on 11/8/24.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        let catName = userInfo["catName"] as! String
        let angerLevel = userInfo["angerLevel"] as! Int
        
        switch response.actionIdentifier {
        case "FeedAction":
            // Handle Feed Action tapped
            break
        case "IgnoreAction":
            // Handle Ignore Action tapped
            break
        default: break
        }
        
        completionHandler()
    }
}

@main
struct notifi_cat_ionApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//
//  ContentView.swift
//  notifi-cat-ion
//
//  Created by Jia Chen Yee on 11/8/24.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    
    // Create a property to store the current notification center
    private let center = UNUserNotificationCenter.current()
    
    @State private var authorizationStatus: UNAuthorizationStatus = .notDetermined
    
    var body: some View {
        NavigationStack {
            List {
                Image(.cat)
                    .resizable()
                    .scaledToFit()
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                
                if authorizationStatus == .authorized || authorizationStatus == .provisional {
                    Section {
                        Button("Meow after 5 seconds", action: timeIntervalTriggerExample)
                        Button("Meow at 1 PM", action: calendarTriggerExample)
                        Button("Meow on New Years Day", action: calendarTriggerNewYearsExample)
                        Button("Meow at Pet Store", action: locationTriggerExample)
                        Button("Meow with image to guilt user", action: attachmentsNotificationExample)
                        Button("Time Sensitive meow", action: timeSensitiveNotificationExample)
                        Button("Meow with custom sound", action: soundNotificationExample)
                        Button("Meow with app icon number", action: badgeNotificationExample)
                        Button("Grouped meows", action: groupingNotificationExample)
                        Button("Actionable meowing", action: actionsNotificationExample)
                    }
                }
            }
            .navigationTitle("notifi-cat-ion")
        }
        .task {
            _ = try? await center.requestAuthorization(options: [.alert, .sound, .badge])
            
            let settings = await center.notificationSettings()
            authorizationStatus = settings.authorizationStatus
        }
    }
    
    func timeIntervalTriggerExample() {
        let content = UNMutableNotificationContent()
        
        content.title = "Meow!"
        content.body = "IM HUNGRY!! Do you like my notifiCATion?? Get it?? Now feed me."
        
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        center.add(UNNotificationRequest(identifier: "TimeIntervalExample",
                                         content: content,
                                         trigger: trigger))
    }
    
    func calendarTriggerExample() {
        let content = UNMutableNotificationContent()
        
        content.title = "Meow!"
        content.body = "IM HUNGRY!! ITS 1 PM!!! FEED ME!"
        
        content.sound = .default
        
        var date = DateComponents()
        date.hour = 1
        date.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        center.add(UNNotificationRequest(identifier: "1PMNotification",
                                         content: content,
                                         trigger: trigger))
    }
    
    func calendarTriggerNewYearsExample() {
        let content = UNMutableNotificationContent()
        
        content.title = "MEOW!! Happy New Year!"
        content.body = "IM STILL HUNGRY!!"
        content.sound = .default
        
        var date = DateComponents()
        date.hour = 0
        date.minute = 0
        date.month = 1
        date.day = 1
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        center.add(UNNotificationRequest(identifier: "NewYearNotification",
                                         content: content,
                                         trigger: trigger))
    }
    
    func locationTriggerExample() {
        let content = UNMutableNotificationContent()
        
        content.title = "TREATS! I NEED TREATS!!"
        content.body = "MEOW!! I NEED TREATS!!!"
        
        content.sound = .default
        
        let location = CLLocationCoordinate2D(latitude: 1.298338, longitude: 103.788588)
        
        // Triggers when within 2 kilometers from the location
        let region = CLCircularRegion(center: location, radius: 2000.0, identifier: "Pet Store")
        
        region.notifyOnEntry = true
        region.notifyOnExit = false
        
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        center.add(UNNotificationRequest(identifier: "PetStoreReminder",
                                         content: content,
                                         trigger: trigger))
    }
    
    func attachmentsNotificationExample() {
        let content = UNMutableNotificationContent()
        
        content.title = "HELLO IM HUNGRY!"
        content.subtitle = "i havent eaten in a month!!"
        content.body = "dont listen to what anyone else says! im hungry!! 😾😾"
        
        let image = Bundle.main.url(forResource: "AngryCat", withExtension: "png")!
        
        content.attachments = [
            try! UNNotificationAttachment(identifier: "catimage", url: image)
        ]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        center.add(UNNotificationRequest(identifier: "FeedCat",
                                         content: content,
                                         trigger: trigger))
    }
    
    func timeSensitiveNotificationExample() {
        let content = UNMutableNotificationContent()
        
        content.title = "HELLO IM HUNGRY!"
        content.subtitle = "i havent eaten in a month!!"
        content.body = "dont listen to what anyone else says! im hungry!! 😾😾"
        
        content.interruptionLevel = .timeSensitive
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        center.add(UNNotificationRequest(identifier: "FeedCat",
                                         content: content,
                                         trigger: trigger))
    }
    
    func soundNotificationExample() {
        let content = UNMutableNotificationContent()
        
        content.title = "HELLO IM HUNGRY!"
        content.subtitle = "i havent eaten in a month!!"
        content.body = "dont listen to what anyone else says! im hungry!! 😾😾"
        
        content.sound = UNNotificationSound(named: UNNotificationSoundName("Purr"))
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        center.add(UNNotificationRequest(identifier: "FeedCat",
                                         content: content,
                                         trigger: trigger))
    }
    
    func badgeNotificationExample() {
        let content = UNMutableNotificationContent()
        
        content.title = "HELLO IM HUNGRY!"
        content.subtitle = "i havent eaten in a month!!"
        content.body = "dont listen to what anyone else says! im hungry!! 😾😾"
        
        content.badge = 100
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        center.add(UNNotificationRequest(identifier: "FeedCat",
                                         content: content,
                                         trigger: trigger))
    }
    
    func groupingNotificationExample() {
        let notification1Content = UNMutableNotificationContent()
        
        notification1Content.title = "HELLO I WANT TO EAT!!!"
        notification1Content.subtitle = "i havent eaten in a month!!"
        notification1Content.body = "dont listen to what anyone else says! im hungry!! 😾😾"
        
        notification1Content.threadIdentifier = "HungryCat"
        
        
        let notification2Content = UNMutableNotificationContent()
        
        notification2Content.title = "HELLO I WANT TO SLEEP!!!"
        notification2Content.subtitle = "dont you dare wake me up"
        notification2Content.body = "im a sleepy cat. if you touch me i will avoid you."
        
        notification2Content.threadIdentifier = "SleepyCat"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        center.add(UNNotificationRequest(identifier: "FeedCat",
                                         content: notification1Content,
                                         trigger: trigger))
        
        center.add(UNNotificationRequest(identifier: "SleepyCat",
                                         content: notification2Content,
                                         trigger: trigger))
    }
    
    func actionsNotificationExample() {
        let content = UNMutableNotificationContent()
        
        content.title = "HELLO IM HUNGRY!"
        content.subtitle = "i havent eaten in a month!!"
        content.body = "dont listen to what anyone else says! im hungry!! 😾😾"
        
        content.userInfo = [
            "catName": "pommy",
            "angerLevel": 100
        ]
        
        let feedAction = UNNotificationAction(identifier: "FeedAction",
                                              title: "Feed",
                                              options: [])
        let ignoreAction = UNNotificationAction(identifier: "IgnoreAction",
                                                title: "Ignore",
                                                options: [.destructive])
        
        let notificationCategory = UNNotificationCategory(identifier: "CatFeedRequest",
                                                          actions: [feedAction, ignoreAction],
                                                          intentIdentifiers: [],
                                                          hiddenPreviewsBodyPlaceholder: "",
                                                          options: [.customDismissAction])
        
        center.setNotificationCategories([notificationCategory])
        
        content.categoryIdentifier = "CatFeedRequest"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        center.add(UNNotificationRequest(identifier: "FeedCat",
                                         content: content,
                                         trigger: trigger))
    }
}

#Preview {
    ContentView()
}

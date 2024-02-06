//
//  AppDelegate.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/20/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        scheduleDailyNotification()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func scheduleDailyNotification() {
           let content = UNMutableNotificationContent()
           content.title = "SeSAC Shopping"
           content.body = "쇼핑 리스트를 관리해보세요!"
           content.sound = .default

           var dateComponents = DateComponents()
           dateComponents.hour = 0
           dateComponents.minute = 0
           let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

           let request = UNNotificationRequest(identifier: "dailyReminder", content: content, trigger: trigger)

           UNUserNotificationCenter.current().add(request) { error in
               print(error ?? "매 자정에 알림이 정상 등록되었습니다.")
           }
       }
}


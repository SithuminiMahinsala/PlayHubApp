//
//  NotificationService.swift
//  PlayHubApp
//
//  Created by COBSCCOMP242P-001 on 2026-07-07.
//

import Foundation
import UserNotifications

class NotificationService {
    static let shared = NotificationService()
    
    private init() {}
    
    // Request permission from the user
    func requestPermission(completion: @escaping (Bool) -> Void = { _ in }) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error)")
            }
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
    
    // Schedule daily reminder at  specific time
    func scheduleDailyReminder(at time: Date) {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Daily Challenge Ready!"
        content.body = "Jump back into PlayHub and beat your high score in Quiz Rush or Tap Frenzy!"
        content.sound = .default
        
        // Extract hour and minute from selected Date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: time)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: "dailyReminder", content: content, trigger: trigger)
        
        center.add(request) { error in
            if let error = error {
                print("Error scheduling reminder: \(error)")
            } else {
                print("Daily reminder scheduled for \(components.hour ?? 0):\(components.minute ?? 0)")
            }
        }
    }
    
    func cancelAllReminders() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}

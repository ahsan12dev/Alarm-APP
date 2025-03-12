//
//  AlarmListViewModel.swift
//  Alarm APP
//
//  Created by Ahsan Aqeel on 11/03/2025.
//

import Foundation
import UserNotifications
import SwiftData

final class AlarmListViewModel: ObservableObject {
    @Published var searchbyAlarmTime: String = ""
    @Published var filteredAlarms: [Alarm] = []
    @Published var selectedAlarmObj: Alarm?
    @Published var addAlarmSheet = false
    @Published var alarms: [Alarm]
    init(alarms: [Alarm]) {
        self.alarms = alarms
    }
    
    func checkAndTriggerNotification(for alarm: Alarm) {
        let currentTime = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
        
        if alarm.time == currentTime {
            let content = UNMutableNotificationContent()
            content.title = "⏰ Alarm!"
            content.subtitle = "Alarm time is reached, \(alarm.time) today!"
            content.body = "\(alarm.note)  \(alarm.repeatOption)"
            content.sound = UNNotificationSound.default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
            print("🔔 Alarm ringed at \(alarm.time)")
        }
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("✅ Notifications allowed.")
            } else {
                print("❌ Notifications denied.")
            }
        }
    }
    
    func filterAlarm(){
        if searchbyAlarmTime.isEmpty{
            filteredAlarms = alarms
        } else {
            filteredAlarms = alarms.filter { Alarm in
                Alarm.time.lowercased().contains(searchbyAlarmTime.lowercased())
            }
        }
    }
}

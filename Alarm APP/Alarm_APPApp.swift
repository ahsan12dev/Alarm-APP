//
//  Alarm_APPApp.swift
//  Alarm APP
//
//  Created by Ahsan Aqeel on 11/03/2025.
//
import SwiftData
import SwiftUI

@main
struct Alarm_APPApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Alarm.self)
    }
}

//
//  SettingsViewModel.swift
//  FeedRss
//
//  Created by Mario Ban on 14.11.2024..
//


import Foundation
import Combine
import UserNotifications
import SwiftUI

@MainActor
class SettingsViewModel: ObservableObject {
    @Published var notificationsEnabled: Bool = false {
        didSet {
            handleNotificationPreferenceChange(isEnabled: notificationsEnabled)
        }
    }
    
    init() {
        checkNotificationStatus()
    }
    
    private func handleNotificationPreferenceChange(isEnabled: Bool) {
        if isEnabled {
            requestNotificationPermission()
        } else {
            disableNotifications()
        }
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { [weak self] granted, _ in
            DispatchQueue.main.async {
                self?.notificationsEnabled = granted
                if granted {
                    //print("Notifications enabled")
                } else {
                    //print("Notifications permission denied")
                }
            }
        }
    }
    
    private func disableNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        print("All notifications canceled and disabled.")
    }
    
    private func checkNotificationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { [weak self] settings in
            DispatchQueue.main.async {
                self?.notificationsEnabled = settings.authorizationStatus == .authorized
            }
        }
    }
}

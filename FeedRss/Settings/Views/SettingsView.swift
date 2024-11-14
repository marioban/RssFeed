//
//  SettingsView.swift
//  FeedRss
//
//  Created by Mario Ban on 13.11.2024..
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Notifications")) {
                    Toggle(isOn: $viewModel.notificationsEnabled) {
                        Text("Send Notifications")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}

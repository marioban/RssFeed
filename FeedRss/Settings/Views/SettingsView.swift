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
                Section(header: Text("Notifications").foregroundColor(.white)) {
                    Toggle(isOn: $viewModel.notificationsEnabled) {
                        Text("Send Notifications")
                    }
                    .tint(.blue)
                }
            }
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Settings")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                }
            }
            .customBackground()
        }
    }
}

#Preview {
    SettingsView()
}

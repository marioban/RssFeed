//
//  MainTabView.swift
//  FeedRss
//
//  Created by Mario Ban on 13.11.2024..
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            SearchFeedsView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}

#Preview {
    MainTabView()
}

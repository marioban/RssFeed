//
//  FeedRssApp.swift
//  FeedRss
//
//  Created by Mario Ban on 09.11.2024..
//

import SwiftUI
import SwiftData

@main
struct FeedRssApp: App {
    private let modelContainer: ModelContainer
    
    
    init() {
        do {
            modelContainer = try ModelContainer(for: RssFeed.self, FeedArticle.self)
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .modelContainer(modelContainer)
        }
    }
}

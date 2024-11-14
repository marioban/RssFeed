//
//  FeedItemsViewModel.swift
//  FeedRss
//
//  Created by Mario Ban on 14.11.2024..
//

import Foundation
import SwiftUI
import Combine
import SwiftData

@MainActor
class FeedItemsViewModel: ObservableObject {
    @Published var feedItems: [FeedArticle]
    private var modelContext: ModelContext
    let feed: RssFeed
    
    init(feed: RssFeed, feedItems: [FeedArticle], modelContext: ModelContext) {
        self.feed = feed
        self.feedItems = feedItems
        self.modelContext = modelContext
    }
    
    func toggleFavorite(for item: FeedArticle) {
        item.isFavorite.toggle()
        saveChanges()
    }
    
    private func saveChanges() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save favorite status: \(error)")
        }
    }
}

//
//  RssFeedListViewModel.swift
//  FeedRss
//
//  Created by Mario Ban on 14.11.2024..
//

import Foundation
import SwiftData
import Combine

@MainActor
class RssFeedListViewModel: ObservableObject {
    @Published var feeds: [RssFeed]
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    var modelContext: ModelContext? 
    
    init(feeds: [RssFeed]) {
        self.feeds = feeds
    }
    
    func deleteFeed(_ feed: RssFeed) {
        guard let modelContext = modelContext else { return }
        modelContext.delete(feed)
        do {
            try modelContext.save()
            feeds.removeAll { $0.id == feed.id }
        } catch {
            alertMessage = "Failed to delete feed. Please try again."
            showAlert = true
        }
    }
    
    func toggleFavorite(for feed: RssFeed) {
        guard let modelContext = modelContext else { return }
        feed.isFavorite.toggle()
        do {
            try modelContext.save()
        } catch {
            alertMessage = "Failed to save favorite status. Please try again."
            showAlert = true
        }
    }
}

//
//  SearchFeedsViewModel.swift
//  FeedRss
//
//  Created by Mario Ban on 16.11.2024..
//


import Foundation
import SwiftData
import Combine

@MainActor
class SearchFeedsViewModel: ObservableObject {
    @Published var searchUrl: String = ""
    @Published var feedItems: [FeedArticle] = []
    @Published var recentFeeds: [RssFeed] = []
    @Published var isSearching: Bool = false
    @Published var selectedFeed: RssFeed?
    
    private var modelContext: ModelContext?
    
    func initialize(with modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchRecentFeeds()
    }
    
    // Fetch recent feeds
    func fetchRecentFeeds() {
        guard let modelContext = modelContext else { return }
        let fetchRequest = FetchDescriptor<RssFeed>(sortBy: [SortDescriptor(\.title)])
        
        do {
            recentFeeds = try modelContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch recent feeds: \(error)")
        }
    }
    
    // Search for a new RSS feed
    func searchRssFeed() {
        guard let modelContext = modelContext, !searchUrl.isEmpty else { return }
        
        Task {
            do {
                let parser = RssParser(feed: RssFeed(url: searchUrl, title: ""))
                let (feed, articles) = try await parser.parseFeed(from: searchUrl)
                
                modelContext.insert(feed)
                feed.articles = articles
                
                for article in articles {
                    modelContext.insert(article)
                }
                
                self.selectedFeed = feed
                self.feedItems = articles
                self.isSearching = true
                fetchRecentFeeds() 
            } catch {
                print("Failed to parse RSS feed: \(error)")
            }
        }
    }
    
    func deleteFeed(_ feed: RssFeed) {
        guard let modelContext = modelContext else { return }
        modelContext.delete(feed)
        do {
            try modelContext.save()
            recentFeeds.removeAll { $0.id == feed.id }
        } catch {
            print("Failed to delete feed: \(error)")
        }
    }
    
    func toggleFavorite(for feed: RssFeed) {
        guard let modelContext = modelContext else { return }
        feed.isFavorite.toggle()
        do {
            try modelContext.save()
        } catch {
            print("Failed to toggle favorite: \(error)")
        }
    }
}

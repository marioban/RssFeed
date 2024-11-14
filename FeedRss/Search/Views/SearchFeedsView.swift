//
//  SearchFeedsView.swift
//  FeedRss
//
//  Created by Mario Ban on 11.11.2024..
//

import SwiftUI
import SwiftData

struct SearchFeedsView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var searchUrl: String = ""
    @State private var feedItems: [FeedArticle] = []
    @State private var isSearching = false
    @State private var rssFeed: RssFeed?
    
    @Query(sort: \RssFeed.title) private var recentFeeds: [RssFeed]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                
                SearchBarView(rss: $searchUrl, onSearch: searchRssFeed)
                
                ShowListTitleView(text: "Show latest searches")
                
                    RssFeedListView(feeds: recentFeeds)
                    .listStyle(.inset)
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Text("Search Rss Feeds")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)
                }
            }
            .navigationDestination(isPresented: $isSearching) {
                if let feed = rssFeed {
                    FeedItemsView(feed: feed, feedItems: feedItems)
                }
            }
        }
    }
    
    private func searchRssFeed() {
        guard !searchUrl.isEmpty else { return }
        
        Task {
            do {
                let parser = RssParser(feed: RssFeed(url: searchUrl, title: ""))
                let (feed, articles) = try await parser.parseFeed(from: searchUrl)
                
                modelContext.insert(feed)
                feed.articles = articles
                
                for article in articles {
                    modelContext.insert(article)
                }
                
                self.rssFeed = feed
                self.feedItems = articles
                self.isSearching = true
            } catch {
                print("Failed to parse RSS feed: \(error)")
            }
        }
    }
}

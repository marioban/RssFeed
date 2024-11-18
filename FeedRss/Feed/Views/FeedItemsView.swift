//
//  FeedItemsView.swift
//  FeedRss
//
//  Created by Mario Ban on 12.11.2024..
//

import SwiftUI

struct FeedItemsView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: FeedItemsViewModel?
    @State private var refreshTrigger = false
    
    let feed: RssFeed
    let feedItems: [FeedArticle]
    
    var body: some View {
        ZStack {
            if let viewModel = viewModel {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        HeaderRssFeed(feed: viewModel.feed)
                            .padding(.bottom, 16)
                        
                        ForEach(viewModel.feedItems) { item in
                            ArticleCardView(feedItem: item)
                                .padding(.horizontal)
                                .cornerRadius(12)
                                .shadow(radius: 3)
                        }
                    }
                    .padding(.vertical)
                }
                .navigationTitle("\(viewModel.feed.title) Articles")
                .foregroundColor(.white)
            } else {
                Text("Loading...")
                    .foregroundColor(.white)
                    .onAppear {
                        self.viewModel = FeedItemsViewModel(feed: feed, feedItems: feedItems, modelContext: modelContext)
                        incrementViewCount(for: feed)
                    }
            }
        }
        .id(refreshTrigger)
        .onAppear {
            incrementViewCount(for: feed)
            refreshTrigger.toggle() 
        }
        .customBackground()
    }
    
    private func incrementViewCount(for feed: RssFeed) {
        feed.viewCount += 1
        do {
            try modelContext.save()
        } catch {
            print("Failed to increment view count: \(error)")
        }
    }
}

#Preview {
    FeedItemsView(feed: RssFeed(url: "https://example.com", title: "Sample Feed", feedDescription: "This is a sample RSS feed", imageUrl: nil), feedItems: [])
}

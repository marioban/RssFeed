//
//  FavoriteFeedsListView.swift
//  FeedRss
//
//  Created by Mario Ban on 16.11.2024..
//


import SwiftUI

struct FavoriteFeedsListView: View {
    let feeds: [RssFeed]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        if feeds.isEmpty {
            FavoritesEmptyStateView(imageName: "newspaper", message: "No favorite feeds found.")
        } else {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(feeds) { feed in
                        HStack {
                            NavigationLink(destination: FeedItemsView(feed: feed, feedItems: feed.articles)) {
                                RssFeedListRowView(feed: feed)
                                    .padding(.horizontal)
                            }
                            
                            Spacer()
                            
                            FavoriteButton(isFavorite: .constant(feed.isFavorite)) {
                                toggleFavorite(for: feed)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    private func toggleFavorite(for feed: RssFeed) {
        feed.isFavorite.toggle()
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


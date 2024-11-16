//
//  SearchFeedRow.swift
//  FeedRss
//
//  Created by Mario Ban on 16.11.2024..
//

import SwiftUI

struct SearchFeedRow: View {
    let feed: RssFeed
    @ObservedObject var viewModel: SearchFeedsViewModel
    
    var body: some View {
        NavigationLink(destination: FeedItemsView(feed: feed, feedItems: feed.articles)) {
            RssFeedListRowView(feed: feed)
                .padding(.horizontal)
                .contextMenu {
                    Button(action: {
                        viewModel.toggleFavorite(for: feed)
                    }) {
                        Label("Add to favorites", systemImage: "star.fill")
                    }
                    
                    Button(action: {
                        viewModel.deleteFeed(feed)
                    }) {
                        Label("Remove from latest searches", systemImage: "trash")
                    }
                }
        }
    }
}

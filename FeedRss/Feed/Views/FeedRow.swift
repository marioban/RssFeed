//
//  FeedRow.swift
//  FeedRss
//
//  Created by Mario Ban on 16.11.2024..
//

import SwiftUI

struct FeedRow: View {
    let feed: RssFeed
    @ObservedObject var viewModel: SearchFeedsViewModel
    
    var body: some View {
        NavigationLink(destination: FeedItemsView(feed: feed, feedItems: feed.articles)) {
            RssFeedListRowView(feed: feed)
                .padding(.horizontal)
                .padding(.leading)
                .contextMenu {
                    Button(action: {
                        viewModel.deleteFeed(feed)
                    }) {
                        Label("Remove from favorites", systemImage: "trash")
                    }
                }
        }
    }
}

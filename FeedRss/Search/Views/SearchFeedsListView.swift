//
//  SearchFeedsListView.swift
//  FeedRss
//
//  Created by Mario Ban on 16.11.2024..
//

import SwiftUI

struct SearchFeedsListView: View {
    let feeds: [RssFeed]
    @ObservedObject var viewModel: SearchFeedsViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                ForEach(feeds) { feed in
                    SearchFeedRow(feed: feed, viewModel: viewModel)
                }
            }
            .padding(.horizontal)
        }
    }
}

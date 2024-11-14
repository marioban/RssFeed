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

    let feed: RssFeed
    let feedItems: [FeedArticle]
    
    var body: some View {
        Group {
            if let viewModel = viewModel {
                List {
                    HeaderRssFeed(feed: viewModel.feed)
                    
                    ForEach(viewModel.feedItems) { item in
                        ArticleCardView(feedItem: item)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .cornerRadius(12)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button {
                                    viewModel.toggleFavorite(for: item)
                                } label: {
                                    Label(
                                        item.isFavorite ? "Remove Favorite" : "Favorite",
                                        systemImage: item.isFavorite ? "star.slash" : "star"
                                    )
                                }
                                .tint(item.isFavorite ? .red : .yellow)
                            }
                    }
                }
                .listStyle(.inset)
                .navigationTitle("\(viewModel.feed.title) Articles")
            } else {
                Text("Loading...") // or a progress view
                    .onAppear {
                        self.viewModel = FeedItemsViewModel(feed: feed, feedItems: feedItems, modelContext: modelContext)
                    }
            }
        }
    }
}

#Preview {
    FeedItemsView(feed: RssFeed(url: "https://example.com", title: "Sample Feed", feedDescription: "This is a sample RSS feed", imageUrl: nil), feedItems: [])
}

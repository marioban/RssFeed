//
//  RssFeedListView.swift
//  FeedRss
//
//  Created by Mario Ban on 11.11.2024..
//

import SwiftUI
import SwiftData

struct RssFeedListView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: RssFeedListViewModel
    
    init(feeds: [RssFeed]) {
        _viewModel = StateObject(wrappedValue: RssFeedListViewModel(feeds: feeds))
    }
    
    var body: some View {
        List {
            ForEach(viewModel.feeds) { feed in
                feedRow(for: feed)
                    .listRowBackground(Color.clear)
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.clear)
        .alert("Error", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.alertMessage)
        }
        .onAppear {
            viewModel.modelContext = modelContext 
        }
    }
    
    private func feedRow(for feed: RssFeed) -> some View {
        NavigationLink(destination: FeedItemsView(feed: feed, feedItems: feed.articles)) {
            RssFeedListRowView(feed: feed)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            deleteButton(for: feed)
            favoriteButton(for: feed)
        }
    }
    
    private func deleteButton(for feed: RssFeed) -> some View {
        Button(role: .destructive) {
            viewModel.deleteFeed(feed)
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
    
    private func favoriteButton(for feed: RssFeed) -> some View {
        Button {
            viewModel.toggleFavorite(for: feed)
        } label: {
            Label(feed.isFavorite ? "Unfavorite" : "Favorite", systemImage: feed.isFavorite ? "star.slash" : "star")
        }
        .tint(.yellow)
    }
}

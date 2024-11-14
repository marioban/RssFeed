//
//  FavoritesView.swift
//  FeedRss
//
//  Created by Mario Ban on 13.11.2024..
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showFavoriteFeeds = true
    @Query(filter: #Predicate { $0.isFavorite == true }, sort: \RssFeed.title) private var favoriteFeeds: [RssFeed]
    @Query(filter: #Predicate { $0.isFavorite == true }, sort: \FeedArticle.title) private var favoriteArticles: [FeedArticle]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button("Favorite Feeds") {
                        showFavoriteFeeds = true
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(showFavoriteFeeds ? .blue : .gray)
                    
                    Button("Favorite Articles") {
                        showFavoriteFeeds = false
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(!showFavoriteFeeds ? .blue : .gray)
                }
                .padding()
                
                if showFavoriteFeeds {
                    List(favoriteFeeds) { feed in
                        NavigationLink(destination: FeedItemsView(feed: feed, feedItems: feed.articles)) {
                            RssFeedListRowView(feed: feed)
                        }
                        .listStyle(.inset)
                    }
                } else {
                    if favoriteArticles.isEmpty {
                        Text("No favorite articles found.")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        List(favoriteArticles) { article in
                            ArticleCardView(feedItem: article)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        deleteFavorite(article)
                                    } label: {
                                        Label("Remove Favorite", systemImage: "star.slash")
                                    }
                                }
                        }
                        .listStyle(.inset)
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
    
    private func deleteFavorite(_ article: FeedArticle) {
        article.isFavorite = false
        do {
            try modelContext.save()
        } catch {
            print("Failed to update favorite status: \(error)")
        }
    }
}

#Preview {
    FavoritesView()
}

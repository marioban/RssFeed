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
    @State private var pickFavorite = 0
    
    
    var body: some View {
        NavigationView {
            VStack {
                FavoritesHeaderView(pickFavorite: $pickFavorite)
                
                if pickFavorite == 0 {
                    if favoriteFeeds.isEmpty {
                        FavoritesEmptyStateView(imageName: "newspaper", message: "No favorite feeds found.")
                    } else {
                        FavoriteFeedsListView(feeds: favoriteFeeds)
                    }
                } else {
                    if favoriteArticles.isEmpty {
                        FavoritesEmptyStateView(imageName: "magnifyingglass", message: "No favorite articles found.")
                    } else {
                        FavoriteArticlesListView(articles: favoriteArticles)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Favorites")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                }
            }
            .customBackground()
        }
    }
}

#Preview {
    FavoritesView()
}

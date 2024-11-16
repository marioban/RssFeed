//
//  FavoriteArticlesListView.swift
//  FeedRss
//
//  Created by Mario Ban on 16.11.2024..
//

import SwiftUI


struct FavoriteArticlesListView: View {
    let articles: [FeedArticle]
    
    var body: some View {
        if articles.isEmpty {
            FavoritesEmptyStateView(imageName: "magnifyingglass", message: "No favorite articles found.")
        } else {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(articles) { article in
                        ArticleCardView(feedItem: article)
                            .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
        }
    }
}

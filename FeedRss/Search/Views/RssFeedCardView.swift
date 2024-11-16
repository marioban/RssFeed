//
//  RssFeedCardView.swift
//  FeedRss
//
//  Created by Mario Ban on 16.11.2024..
//

import SwiftUI
import SwiftData

struct RssFeedCardView: View {
    let feed: RssFeed
    @State private var isFavorite: Bool
    private var modelContext: ModelContext?
    
    init(feed: RssFeed) {
        self.feed = feed
        _isFavorite = State(initialValue: feed.isFavorite)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .topTrailing) {
                ArticleImageView(imageUrl: feed.imageUrl)
                
                FavoriteButton(isFavorite: $isFavorite) {
                    toggleFavorite()
                }
            }
            
            ArticleOverlayView(title: feed.title, description: feed.feedDescription)
        }
        .background(Color(red: 0.059, green: 0.071, blue: 0.114))
        .cornerRadius(10)
        .shadow(radius: 5, x: 0, y: 5)
    }
    
    private func toggleFavorite() {
        isFavorite.toggle()
        feed.isFavorite = isFavorite
        saveChanges()
    }
    
    private func saveChanges() {
        do {
            try modelContext?.save()
        } catch {
            print("Failed to save favorite status: \(error)")
        }
    }
}

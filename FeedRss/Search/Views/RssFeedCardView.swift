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
    @State private var showAlert = false
    @State private var alertMessage = ""
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
        .overlay(
            Group {
                if showAlert {
                    Text(alertMessage)
                        .font(.subheadline)
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .transition(.opacity)
                        .zIndex(1)
                }
            }
            .animation(.easeInOut(duration: 0.3), value: showAlert),
            alignment: .top
        )
    }
    
    private func toggleFavorite() {
        isFavorite.toggle()
        feed.isFavorite = isFavorite
        saveChanges()
        alertMessage = isFavorite ? "Added to Favorites" : "Removed from Favorites"
        showAlert = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showAlert = false
        }
    }
    
    private func saveChanges() {
        do {
            try modelContext?.save()
        } catch {
            print("Failed to save favorite status: \(error)")
        }
    }
}

//
//  ArticleCardView.swift
//  FeedRss
//
//  Created by Mario Ban on 12.11.2024..
//

import SwiftUI
import SwiftData

struct ArticleCardView: View {
    let feedItem: FeedArticle
    @State private var showWebView = false
    @State private var isFavorite: Bool
    private var modelContext: ModelContext?
    
    init(feedItem: FeedArticle) {
        self.feedItem = feedItem
        _isFavorite = State(initialValue: feedItem.isFavorite)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .topTrailing) {
                ArticleImageView(imageUrl: feedItem.imageUrl)
                
                // Favorite Button
                FavoriteButton(isFavorite: $isFavorite) {
                    toggleFavorite()
                }
            }
            
            ArticleOverlayView(title: feedItem.title, description: feedItem.articleDescription)
        }
        .onTapGesture {
            showWebView = true
        }
        .contextMenu {
            Button(action: {
                showWebView = true
            }) {
                Label("Open in App", systemImage: "safari")
            }
            
            Button(action: {
                if let url = URL(string: feedItem.link ?? "") {
                    UIApplication.shared.open(url)
                }
            }) {
                Label("Open in Safari", systemImage: "safari")
            }
        }
        .sheet(isPresented: $showWebView) {
            if let url = URL(string: feedItem.link ?? "") {
                WebView(url: url)
            }
        }
        .background(Color(red: 0.059, green: 0.071, blue: 0.114))
        .cornerRadius(10)
        .shadow(radius: 5, x: 0, y: 5)
    }
    
    private func toggleFavorite() {
        isFavorite.toggle()
        feedItem.isFavorite = isFavorite
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

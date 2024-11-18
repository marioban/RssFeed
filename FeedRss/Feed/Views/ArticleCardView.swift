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
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    init(feedItem: FeedArticle) {
        self.feedItem = feedItem
        _isFavorite = State(initialValue: feedItem.isFavorite)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .topTrailing) {
                ArticleImageView(imageUrl: feedItem.imageUrl)
                
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
        feedItem.isFavorite = isFavorite
        alertMessage = isFavorite ? "Article added to favorites." : "Article removed from favorites."
        showAlert = true
        saveChanges()
        
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

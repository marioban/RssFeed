//
//  ArticleCardView.swift
//  FeedRss
//
//  Created by Mario Ban on 12.11.2024..
//


import SwiftUI

struct ArticleCardView: View {
    let feedItem: FeedArticle
    @State private var showWebView = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if let imageUrlString = feedItem.imageUrl,
               let imageUrl = URL(string: imageUrlString) {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                        .cornerRadius(8)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 250)
                        .cornerRadius(10)
                }
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 250)
                    .cornerRadius(10)
            }
            
            // Title and Description Overlay
            VStack(alignment: .leading, spacing: 4) {
                Text(feedItem.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(2)
                
                if let description = feedItem.articleDescription {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                        .lineLimit(3)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                .cornerRadius(10)
            )
        }
        .cornerRadius(10)
        .shadow(radius: 5, x: 0, y: 5)
        .onTapGesture {
            showWebView = true
        }
        .contextMenu {
            // Open in WebView Option
            Button(action: {
                showWebView = true
            }) {
                Label("Open in App", systemImage: "safari")
            }
            
            // Open in Safari Option
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
    }
}



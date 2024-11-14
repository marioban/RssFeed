//
//  HeaderRssFeed.swift
//  FeedRss
//
//  Created by Mario Ban on 13.11.2024..
//


import SwiftUI

struct HeaderRssFeed: View {
    let feed: RssFeed
    
    var body: some View {
        VStack(alignment: .center) {
            // Display RSS Feed Information
            if let imageUrl = feed.imageUrl, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(10)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 200)
                        .cornerRadius(10)
                }
            }
            
            Text(feed.title)
                .font(.title)
                .fontWeight(.bold)
            
            if let description = feed.feedDescription {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    HeaderRssFeed(feed: RssFeed(url: "https://example.com", title: "Sample Feed", feedDescription: "This is a sample RSS feed", imageUrl: nil))
}

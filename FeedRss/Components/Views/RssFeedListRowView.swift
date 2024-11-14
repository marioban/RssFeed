//
//  RssFeedListRowView.swift
//  FeedRss
//
//  Created by Mario Ban on 13.11.2024..
//
import SwiftUI

struct RssFeedListRowView: View {
    var feed: RssFeed
    
    var body: some View {
        HStack(alignment: .center,spacing: 30) {
            if let imageUrlString = feed.imageUrl, let imageUrl = URL(string: imageUrlString) {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25, height: 25)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 25, height: 25)
                }
            }
            
            
            VStack(alignment: .leading) {
                Text(feed.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                if let description = feed.feedDescription {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.primary.opacity(0.7))
                        .lineLimit(2)
                }
            }
        }
    }
}

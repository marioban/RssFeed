//
//  RssFeedListRowView.swift
//  FeedRss
//
//  Created by Mario Ban on 13.11.2024..
//
import SwiftUI
import SwiftData

struct RssFeedListRowView: View {
    var feed: RssFeed
    
    var body: some View {
        HStack(alignment: .center,spacing: 30) {
            if let imageUrlString = feed.imageUrl, let imageUrl = URL(string: imageUrlString) {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                } placeholder: {
                    PlaceholderView()
                        .frame(width: 25, height: 25)
                }
            }
            
            
            VStack(alignment: .leading) {
                Text(feed.title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                if let description = feed.feedDescription {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .lineLimit(2)
                }
            }
        }
    }
}

//
//  RssFeedListView.swift
//  FeedRss
//
//  Created by Mario Ban on 11.11.2024..
//

import SwiftUI

struct RssFeedListView: View {
    
    @Binding var feeds: [String]
    
    var body: some View {
        List {
            ForEach(feeds, id:\.self) { feed in
                Text(feed)
                    .foregroundStyle(Color.white)
                    .font(.headline)
                    .listRowBackground(Color.clear)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            delete(feed)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        
                        Button {
                            markAsFavorite(feed)
                        } label: {
                            Label("Favorite", systemImage: "star")
                        }
                        .tint(.yellow)
                    }
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.clear)
    }
    
    // Placeholder delete function
    private func delete(_ feed: String) {
        if let index = feeds.firstIndex(of: feed) {
            feeds.remove(at: index)
        }
    }
    
    // Placeholder favorite function
    private func markAsFavorite(_ feed: String) {
        // Later, implement favorite saving logic with SwiftData
        print("Marked \(feed) as favorite")
    }
}

#Preview {
    RssFeedListView(feeds: .constant([
        "https://feeds.bbci.co.uk/news/world/rss.xml",
        "http://rss.cnn.com/rss/edition.rss",
        "https://rss.nytimes.com/services/xml/rss/nyt/World.xml"
    ]))
}

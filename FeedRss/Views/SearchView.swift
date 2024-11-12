//
//  SearchView.swift
//  FeedRss
//
//  Created by Mario Ban on 11.11.2024..
//

import SwiftUI

struct SearchView: View {
    @State private var rss: String = ""
    @State private var showFavorite: Bool = false
    @State private var showLatest: Bool = false
    @State private var favoriteIcon = "chevron.down"
    @State private var latestIcon = "chevron.down"
    
    @State private var rssFeeds = [
        "https://feeds.bbci.co.uk/news/world/rss.xml",
        "http://rss.cnn.com/rss/edition.rss",
        "https://rss.nytimes.com/services/xml/rss/nyt/World.xml",
        "http://feeds.reuters.com/reuters/topNews",
        "https://www.theguardian.com/world/rss",
        "https://www.aljazeera.com/xml/rss/all.xml",
        "https://www.npr.org/rss/rss.php?id=1001",
        "http://feeds.foxnews.com/foxnews/latest",
        "https://abcnews.go.com/abcnews/topstories",
        "https://www.cnbc.com/id/100727362/device/rss/rss.html"
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.cyan]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        TextField("Enter rss", text: $rss)
                            .keyboardType(.URL)
                            .textInputAutocapitalization(.never)
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.blue)
                            .fontWeight(.bold)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 1))
                    .padding(.horizontal)
                    .padding(.top)
                    
                    ShowListTitleView(text: "Show favorites", icon: $favoriteIcon, isExpanded: $showFavorite)
                    
                    
                    if showFavorite {
                        RssFeedListView(feeds: $rssFeeds)
                            .transition(.slide)
                    }
                    
                    ShowListTitleView(text: "Show latest searches", icon: $latestIcon, isExpanded: $showLatest)
                    
                    if showLatest {
                        RssFeedListView(feeds: $rssFeeds)
                            .transition(.slide)
                    }
                    
                    Spacer()
                }
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Text("Search Rss Feeds")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.top)
                    }
                }
            }
        }
    }
}

#Preview {
    SearchView()
}




//
//  RssFeed.swift
//  FeedRss
//
//  Created by Mario Ban on 11.11.2024..
//

import Foundation
import SwiftData

@Model
class RssFeed: Identifiable {
    @Attribute(.unique) var url: String
    var title: String
    var link: String?
    var feedDescription: String?
    var imageUrl: String?
    var isFavorite: Bool = false
    
    var articles: [FeedArticle] = []
    
    init(url: String, link: String? = nil, title: String, feedDescription: String? = nil, imageUrl: String? = nil) {
        self.url = url
        self.link = link
        self.title = title
        self.feedDescription = feedDescription
        self.imageUrl = imageUrl
    }
}

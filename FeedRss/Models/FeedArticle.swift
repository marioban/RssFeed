//
//  FeedArticle.swift
//  FeedRss
//
//  Created by Mario Ban on 11.11.2024..
//

import Foundation
import SwiftData

@Model
class FeedArticle: Identifiable {
    var title: String
    var imageUrl: String?
    var articleDescription: String?
    var link: String?
    var publishedDate: Date?
    var isFavorite: Bool = false
    
    weak var rssFeed: RssFeed?
    
    init(title: String, imageUrl: String? = nil, articleDescription: String? = nil, link: String? = nil, publishedDate: Date? = nil, rssFeed: RssFeed) {
        self.title = title
        self.imageUrl = imageUrl
        self.articleDescription = articleDescription
        self.link = link
        self.publishedDate = publishedDate
        self.rssFeed = rssFeed
    }
}

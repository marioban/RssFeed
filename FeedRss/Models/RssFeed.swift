//
//  RssFeed.swift
//  FeedRss
//
//  Created by Mario Ban on 11.11.2024..
//

import Foundation
import SwiftData

@Model
class RssFeed {
    @Attribute(.unique) var url: String
    var title: String
    var feedDescription: String?
    var imageUrl: String?
    var isFavorite: Bool = false
    
    init(url: String, title: String, feedDescription: String? = nil, imageUrl: String? = nil) {
        self.url = url
        self.title = title
        self.feedDescription = feedDescription
        self.imageUrl = imageUrl
    }
}

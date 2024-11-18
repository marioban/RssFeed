//
//  RssParsingError.swift
//  FeedRss
//
//  Created by Mario Ban on 12.11.2024..
//


import SwiftUI

enum RssParsingError: Error {
    case invalidURL
    case parsingFailed
}

protocol RssParserProtocol {
    func parseFeed(from url: String) async throws -> (feed: RssFeed, articles: [FeedArticle])
}

final class RssParser: NSObject, XMLParserDelegate, RssParserProtocol {
    
    private var feedItems = [FeedArticle]()
    private var currentFeed: RssFeed
    private var currentElement = ""
    private var parentElements = [String]()
    
    private var channelTitle: String?
    private var channelLink: String?
    private var channelDescription: String?
    private var channelImageUrl: String?
    
    private var currentTitle: String?
    private var currentLink: String?
    private var currentDescription: String?
    private var currentImageUrl: String?
    
    init(feed: RssFeed) {
        self.currentFeed = feed
    }
    
    func parseFeed(from url: String) async throws -> (feed: RssFeed, articles: [FeedArticle]) {
        guard let feedURL = URL(string: url) else {
            throw RssParsingError.invalidURL
        }
        
        guard let parser = XMLParser(contentsOf: feedURL) else {
            throw RssParsingError.parsingFailed
        }
        
        parser.delegate = self
        guard parser.parse() else {
            throw RssParsingError.parsingFailed
        }
        
        currentFeed.title = channelTitle ?? "Unknown Feed"
        currentFeed.feedDescription = channelDescription
        currentFeed.url = channelLink ?? url
        currentFeed.imageUrl = channelImageUrl
        
        return (feed: currentFeed, articles: feedItems)
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?,
                qualifiedName qName: String?, attributes attributeDict: [String: String]) {
        parentElements.append(elementName)
        currentElement = elementName
        
        switch elementName {
        case "channel":
            resetChannelMetadata()
        case "item":
            resetCurrentItem()
        case "media:thumbnail", "media:content", "enclosure", "image":
            if let url = attributeDict["url"] {
                if isCurrentElementInParent("item") {
                    currentImageUrl = url
                } else if isCurrentElementInParent("channel") {
                    channelImageUrl = url
                }
            }
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let trimmedString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedString.isEmpty else { return }
        
        if parentElements.count >= 2 {
            let parentElement = parentElements[parentElements.count - 2]
            let currentElement = parentElements.last ?? ""
            
            switch (parentElement, currentElement) {
            case ("channel", "title"):
                channelTitle = (channelTitle ?? "") + trimmedString
            case ("channel", "link"):
                channelLink = (channelLink ?? "") + trimmedString
            case ("channel", "description"):
                channelDescription = (channelDescription ?? "") + trimmedString
            case ("image", "url"):
                channelImageUrl = (channelImageUrl ?? "") + trimmedString
            case ("item", "title"):
                currentTitle = (currentTitle ?? "") + trimmedString
            case ("item", "link"):
                currentLink = (currentLink ?? "") + trimmedString
            case ("item", "description"):
                currentDescription = (currentDescription ?? "") + trimmedString
            default:
                break
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?,
                qualifiedName qName: String?) {
        if parentElements.last == elementName {
            parentElements.removeLast()
        }
        currentElement = parentElements.last ?? ""
        
        if elementName == "item" {
            if let feedItem = createFeedItem() {
                feedItems.append(feedItem)
            }
            resetCurrentItem()
        }
    }
    
    // MARK: - Private Helper Methods
    
    private func resetChannelMetadata() {
        channelTitle = nil
        channelLink = nil
        channelDescription = nil
        channelImageUrl = nil
    }
    
    private func resetCurrentItem() {
        currentTitle = nil
        currentLink = nil
        currentDescription = nil
        currentImageUrl = nil
    }
    
    private func createFeedItem() -> FeedArticle? {
        guard let title = currentTitle,
              let link = currentLink else {
            return nil
        }
        
        return FeedArticle(
            title: title,
            imageUrl: currentImageUrl,
            articleDescription: currentDescription,
            link: link,
            publishedDate: Date(),
            rssFeed: currentFeed
        )
    }
    
    private func isCurrentElementInParent(_ parent: String) -> Bool {
        if parentElements.count >= 2 {
            let parentElement = parentElements[parentElements.count - 2]
            return parentElement == parent
        }
        return false
    }
}

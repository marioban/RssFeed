//
//  ArticleImageView.swift
//  FeedRss
//
//  Created by Mario Ban on 16.11.2024..
//

import SwiftUI

struct ArticleImageView: View {
    let imageUrl: String?

    var body: some View {
        if let imageUrlString = imageUrl, let imageUrl = URL(string: imageUrlString) {
            AsyncImage(url: imageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(8)
            } placeholder: {
                PlaceholderView()
            }
        } else {
            PlaceholderView()
        }
    }
}

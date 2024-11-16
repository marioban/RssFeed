//
//  FavoritesEmptyStateView.swift
//  FeedRss
//
//  Created by Mario Ban on 15.11.2024..
//

import SwiftUI

struct FavoritesEmptyStateView: View {
    let imageName: String
    let message: String
    
    var body: some View {
        Spacer()
        VStack {
            Image(systemName: imageName)
                .scaledToFill()
                .foregroundStyle(Color.blue)
                .frame(width: 100, height: 100)
                .background(Color.blue.opacity(0.15))
                .cornerRadius(50)
            Text(message)
                .foregroundColor(.gray)
                .padding()
        }
        Spacer()
    }
}

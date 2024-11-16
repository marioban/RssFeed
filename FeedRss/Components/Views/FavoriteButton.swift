//
//  FavoriteButton.swift
//  FeedRss
//
//  Created by Mario Ban on 16.11.2024..
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isFavorite: Bool
    var onTap: () -> Void

    var body: some View {
        VStack(alignment: .trailing) {
            Image(systemName: isFavorite ? "star.fill" : "star")
                .foregroundColor(isFavorite ? .yellow : .white)
                .padding(10)
                .background(Color.black.opacity(0.6))
                .clipShape(Circle())
                .padding(10)
                .onTapGesture {
                    onTap()
                }
        }
    }
}

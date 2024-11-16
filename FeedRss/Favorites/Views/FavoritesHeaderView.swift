//
//  FavoritesHeaderView.swift
//  FeedRss
//
//  Created by Mario Ban on 16.11.2024..
//

import SwiftUI

struct FavoritesHeaderView: View {
    @Binding var pickFavorite: Int
    
    var body: some View {
        HStack {
            Picker("", selection: $pickFavorite) {
                Text("Favorite Feeds").tag(0)
                Text("Favorite Articles").tag(1)
            }
            .pickerStyle(.segmented)
        }
        .padding()
    }
}

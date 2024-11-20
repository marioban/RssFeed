//
//  SearchBarView.swift
//  FeedRss
//
//  Created by Mario Ban on 12.11.2024..
//

import SwiftUI

struct SearchBarView: View {
    @Binding var rss: String
    @FocusState private var rssFieldIsFocused: Bool
    var onSearch: () -> Void
    
    var body: some View {
        HStack {
            TextField("Enter rss", text: $rss, prompt: Text("Enter rss url").foregroundStyle(Color.white).fontWeight(.light))
                .onSubmit(onSearch)
                .autocapitalization(.none)
                .keyboardType(.URL)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .focused($rssFieldIsFocused)
                
            
            Button(action: onSearch) {
                Image(systemName: "magnifyingglass")
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.primary, lineWidth: 4)
        )
        .background(Color.gray.opacity(0.4))
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.top)
    }
}

#Preview {
    SearchBarView(rss: .constant("")) {}
}

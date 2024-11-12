//
//  ShowListTitleView.swift
//  FeedRss
//
//  Created by Mario Ban on 11.11.2024..
//

import SwiftUI

struct ShowListTitleView: View {
    var text: String
    @Binding var icon: String
    @Binding var isExpanded: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            Text(text)
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .padding()
            
            Image(systemName: icon)
                .foregroundColor(.white)
        }
        .onTapGesture {
            isExpanded.toggle()
            icon = isExpanded ? "chevron.up" : "chevron.down"
        }
    }
}

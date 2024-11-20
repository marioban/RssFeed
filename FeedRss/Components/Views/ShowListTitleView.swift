//
//  ShowListTitleView.swift
//  FeedRss
//
//  Created by Mario Ban on 11.11.2024..
//

import SwiftUI

struct ShowListTitleView: View {
    var text: String
    
    var body: some View {
        HStack(alignment: .center) {
            Text(text)
                .foregroundStyle(Color.white)
                .font(.title)
                .bold()
                .padding(.top)
                .padding(.horizontal)
        }
    }
}

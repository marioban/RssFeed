//
//  BackgroundModifier.swift
//  FeedRss
//
//  Created by Mario Ban on 16.11.2024..
//

import SwiftUI

struct BackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                Color(red: 0.059, green: 0.071, blue: 0.114)
                    .ignoresSafeArea()
            )
    }
}

extension View {
    func customBackground() -> some View {
        self.modifier(BackgroundModifier())
    }
}

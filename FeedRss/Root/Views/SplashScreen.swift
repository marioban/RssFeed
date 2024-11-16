//
//  ContentView.swift
//  FeedRss
//
//  Created by Mario Ban on 09.11.2024..
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var scale = 0.8
    @State private var opacity = 0.0
    
    var body: some View {
        VStack {
            if isActive {
                MainTabView()
                    .customBackground()
                    .transition(.slide)
            } else {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color(red: 0.059, green: 0.071, blue: 0.114), Color(red: 0.059, green: 0.071, blue: 0.114)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .ignoresSafeArea()
                    
                    VStack {
                        Image(systemName: "newspaper")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.white)
                            .scaleEffect(scale)
                            .onAppear {
                                withAnimation(
                                    .easeInOut(duration: 1.5)
                                    .repeatForever(autoreverses: true)
                                ) {
                                    scale = 1.0
                                }
                            }
                        
                        Text("RSS Feed App")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 20)
                    }
                    .opacity(opacity)
                    .onAppear{
                        withAnimation(.bouncy(duration: 2.0)) {
                            opacity = 1.0
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                self.isActive = true
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}

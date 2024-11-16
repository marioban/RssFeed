import SwiftUI
import SwiftData

struct SearchFeedsView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = SearchFeedsViewModel()
    @State private var currentCarouselIndex = 0
    private let carouselTimer = Timer.publish(every: 3.5, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack {
                    VStack(alignment: .leading, spacing: 16) {
                        SearchBarView(rss: $viewModel.searchUrl, onSearch: viewModel.searchRssFeed)
                        
                        ShowListTitleView(text: "Most viewed feeds")
                        
                        if !viewModel.mostViewedFeeds.isEmpty {
                            TabView(selection: $currentCarouselIndex) {
                                ForEach(viewModel.mostViewedFeeds.indices, id: \.self) { index in
                                    RssFeedCardView(feed: viewModel.mostViewedFeeds[index])
                                        .tag(index)
                                }
                            }
                            .tabViewStyle(.page)
                            .frame(height: 300)
                            .onReceive(carouselTimer) { _ in
                                withAnimation {
                                    currentCarouselIndex = (currentCarouselIndex + 1) % viewModel.mostViewedFeeds.count
                                }
                            }
                            .padding(.horizontal,16)
                        }
                        
                        ShowListTitleView(text: "Show latest searches")
                        
                        if viewModel.recentFeeds.isEmpty {
                            FavoritesEmptyStateView(imageName: "magnifyingglass", message: "No recent feeds found.")
                        } else {
                            SearchFeedsListView(feeds: viewModel.recentFeeds, viewModel: viewModel)
                        }
                        
                        Spacer()
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Text("Search Rss Feeds")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.white)
                        }
                    }
                    .navigationDestination(isPresented: $viewModel.isSearching) {
                        if let feed = viewModel.selectedFeed {
                            FeedItemsView(feed: feed, feedItems: viewModel.feedItems)
                        }
                    }
                    
                }
            }
            .customBackground()
            .onAppear {
                viewModel.initialize(with: modelContext)
                viewModel.resetSearchBar()
            }
        }
    }
}
    
    #Preview {
        SearchFeedsView()
    }
    

import SwiftUI
import SwiftData

struct SearchFeedsView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = SearchFeedsViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading, spacing: 16) {
                    SearchBarView(rss: $viewModel.searchUrl, onSearch: viewModel.searchRssFeed)
                    
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
            .customBackground()
        }
        .onAppear {
            viewModel.initialize(with: modelContext)
        }
    }
}

#Preview {
    SearchFeedsView()
}


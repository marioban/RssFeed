# FeedRss

FeedRss is an iOS application that allows users to search, view, and manage RSS feeds efficiently. Users can mark their favorite feeds and articles, manage notifications for new content, and organize their reading experience. The project demonstrates a clean MVVM architecture with SwiftUI, SwiftData, and modular components.

## Table of Contents
- [Features](#features)
- [Screenshots](#screenshots)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Features

- **Search RSS Feeds**: Enter a URL to search and display RSS feed articles.
- **Favorites**: Mark feeds and articles as favorites for quick access.
- **Notifications**: Manage notification settings to receive updates on new articles in favorite feeds.
- **User-Friendly Interface**: Clean and intuitive UI with SwiftUI components.
- **MVVM Architecture**: Structured codebase with separation of views, view models, and services.

## Screenshots

## Architecture

FeedRss uses **MVVM (Model-View-ViewModel)** architecture, ensuring a clean separation of concerns:
- **Models**: Represent the data, including feeds and articles.
- **Views**: SwiftUI views display data and handle user interaction.
- **ViewModels**: Handle the business logic and data management.
- **Services**: Fetch and parse RSS feeds, manage data, and handle notifications.

The project also integrates **SwiftData** for persistence and **SwiftUI** for building a responsive UI.

## Project Structure

```
FeedRss/
├── Components/                     # Shared reusable components
│   ├── ViewModel/
│   │   └── RssFeedListViewModel.swift
│   └── Views/
│       └── RssFeedListView.swift
│
├── Favorites/                      # Favorite feeds and articles feature
│   ├── ViewModel/
│   │   └── FavoritesViewModel.swift
│   └── Views/
│       └── FavoritesView.swift
│
├── Feed/                           # Feed details and articles feature
│   ├── ViewModel/
│   │   └── FeedItemsViewModel.swift
│   └── Views/
│       ├── FeedItemsView.swift
│       └── ArticleCardView.swift
│
├── Models/                         # Data models for feeds and articles
│   ├── FeedArticle.swift
│   └── RssFeed.swift
│
├
│
├── Root/                           # Main app views, such as the entry point
│   └── Views/
│       ├── MainTabView.swift
│       └── SplashScreen.swift
│
├── Search/                         # Search feature
│   ├── ViewModel/
│   │   └── SearchFeedsViewModel.swift
│   └── Views/
│       ├── SearchBarView.swift
│       └── SearchFeedsView.swift
│
├── Service/                        # Service layer for data fetching and web views
│   ├── RssParser.swift
│   └── WebView.swift
│
├── Settings/                       # App settings feature
│   ├── ViewModel/
│   │   └── SettingsViewModel.swift
│   └── Views/
│       └── SettingsView.swift
│
|── FeedRssApp.swift                # Main application entry point
├── Assets/                         # Assets for images, colors, etc.
│── Preview Content/                # Preview data and configurations


```

## Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/FeedRss.git
   ```
   
2. **Open the project in Xcode**:
   ```bash
   cd FeedRss
   open FeedRss.xcodeproj
   ```
   
3. **Run the app**:
   - Select a simulator or your device, then press **Run** (Cmd + R) in Xcode.

## Usage

1. **Search Feeds**: Use the search bar to enter a feed URL and fetch articles.
2. **View Articles**: Select a feed to view its articles in detail.
3. **Favorite Management**: Mark feeds and articles as favorites and access them under the "Favorites" tab.
4. **Settings**: Control notifications and other preferences in the Settings tab.

## Dependencies

- **SwiftData**: Used for data persistence to manage saved feeds and favorites.
- **Combine**: Manages reactive programming elements for better user experience and async handling.

## Contributing

Contributions are welcome! Please fork the repository and create a pull request with any improvements.

1. **Fork the repository**.
2. **Create a new branch** (`git checkout -b feature/YourFeature`).
3. **Commit your changes** (`git commit -am 'Add a new feature'`).
4. **Push to the branch** (`git push origin feature/YourFeature`).
5. **Create a Pull Request**.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Feel free to modify the above README based on your personal preferences or to include more specific details, such as your GitHub profile link, contact information, or specific setup requirements. Let me know if you’d like help with any additional details!

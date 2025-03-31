# 🎬 The Movie DB

A beautiful Flutter application that helps you discover, explore, and keep track of your favorite movies using the TMDB API.

<img src="https://raw.githubusercontent.com/PraveenGongada/MovieDB/refs/heads/main/docs/images/thumbnail.png" alt="App Banner" style="border-radius: 12px;" />

## ✨ Features

### 🏠 Home Screen

- Beautifully designed movie cards with poster images
- Movie categorization by genre (Family, Fantasy, Thriller, Action)
- Popular & Top Rated sections with latest trending movies
- Search functionality to find any movie

### 🎭 Movie Details

- Comprehensive plot summaries
- Full cast information with actor photos
- Official video clips and trailers
- User reviews with ratings
- Similar movie recommendations

### 🔍 Search Functionality

- Real-time search results
- Detailed movie information on search results

### 📱 UI Features

- Dark mode interface for comfortable viewing
- Smooth animations and transitions
- Responsive design for all screen sizes
- Clean, intuitive navigation

## 📱 Screenshots

<div align="center">
  <img src="https://raw.githubusercontent.com/PraveenGongada/MovieDB/refs/heads/main/docs/images/home.png" alt="Home Screen" style="border-radius: 12px;"/>
  <img src="https://raw.githubusercontent.com/PraveenGongada/MovieDB/refs/heads/main/docs/images/movie.png" alt="Movie Details" style="border-radius: 12px;"/>
</div>

## 🎥 Demo

[Click here to view the app demo video](https://raw.githubusercontent.com/PraveenGongada/MovieDB/refs/heads/main/docs/videos/demo.mp4)

## 🛠️ Technology Stack

- **Framework**: Flutter
- **State Management**: Flutter Riverpod & Get
- **API**: TMDB (The Movie Database)
- **Animations**: Animate Do
- **HTTP Client**: http

## 🚀 Getting Started

### Prerequisites

- TMDB API Key

### Installation

1. Clone this repository

```bash
git clone https://github.com/praveengongada/MovieDB.git
```

2. Navigate to the project directory

```bash
cd MovieDB
```

3. Install dependencies

```bash
flutter pub get
```

4. Add your TMDB API key in `lib/Keys/keys.dart`

```dart
class Keys {
  static const tmdb_key = 'YOUR_API_KEY';
}
```

5. Run the app

```bash
flutter run
```

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check [issues page](https://github.com/praveengongada/MovieDB/issues).

## 📄 License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [TMDB](https://www.themoviedb.org/) - for providing the API

---

<div align="center">
  <p>Made with ❤️ by <a href="https://github.com/PraveenGongada">Praveen Kumar</a></p>
  <p>
    <a href="https://linkedin.com/in/praveengongada">LinkedIn</a> •
    <a href="https://praveengongada.com">Website</a>
  </p>
</div>

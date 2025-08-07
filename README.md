# 🚀 Startup Idea Evaluator

A Flutter-based mobile application for entrepreneurs to submit, evaluate, and rank startup ideas through community voting and AI-powered insights.

## 📱 App Description

Startup Idea Evaluator is a comprehensive platform that allows users to share their startup ideas, receive community feedback through voting, and get AI-powered evaluations. The app features a clean, modern interface with dark/light theme support and persistent storage for seamless user experience.

## 🛠️ Tech Stack

### Frontend
- **Flutter** - Cross-platform mobile development framework
- **Dart** - Programming language
- **Provider** - State management
- **Google Fonts** - Typography
- **Font Awesome Icons** - Icon library

### Backend & Services
- **Shared Preferences** - Local data persistence
- **AI Service** - Intelligent idea evaluation
- **Storage Service** - Data management layer

### Development Tools
- **Flutter Launcher Icons** - Custom app icons
- **Flutter Native Splash** - Splash screen management
- **Git** - Version control

## ✨ Features Implemented

### Core Features
- **📝 Idea Submission** - Submit new startup ideas with title, description, and category
- **👍 Community Voting** - Upvote/downvote ideas to rank them
- **🤖 AI Evaluation** - Get intelligent insights on idea viability
- **📊 Leaderboard** - View top-ranked ideas based on community votes
- **🗑️ Delete Functionality** - Remove ideas with confirmation dialogs
- **🌓 Theme Toggle** - Switch between dark and light modes

### UI/UX Features
- **Custom Launcher Icon** - Branded app icon across all platforms
- **Responsive Design** - Optimized for all screen sizes
- **Smooth Animations** - Engaging user interactions
- **Persistent Storage** - Data survives app restarts

## 🚀 How to Run Locally

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / Xcode (for device emulation)

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/Kumarjit-Hazra/Kumarjit-Hazra-startup_idea_evaluator.git
   cd startup_idea_evaluator
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Build APK

To build a release APK for Android:

```bash
flutter build apk --release
```

The APK will be available at: `build/app/outputs/flutter-apk/app-release.apk`

### Build for iOS

To build for iOS:

```bash
flutter build ios --release
```

## 📁 Project Structure

```
lib/
├── models/
│   └── idea.dart              # Idea data model
├── providers/
│   ├── idea_provider.dart     # State management for ideas
│   └── theme_provider.dart    # Theme management
├── screens/
│   ├── listing_screen.dart    # Main idea listing
│   ├── submission_screen.dart # Add new ideas
│   └── leaderboard_screen.dart # Top ideas
├── services/
│   ├── ai_service.dart        # AI evaluation logic
│   └── storage_service.dart   # Data persistence
└── widgets/
    └── custom_text_field.dart # Reusable UI components
```

## 🎯 Usage Guide

1. **Browse Ideas** - View all submitted startup ideas on the main screen
2. **Submit New Idea** - Tap the "+" button to add your startup concept
3. **Vote & Evaluate** - Use upvote/downvote buttons to rank ideas
4. **View Leaderboard** - Check the top-ranked ideas in the leaderboard tab
5. **Delete Ideas** - Long-press on your ideas to delete them
6. **Toggle Theme** - Switch between dark and light modes in the app bar

## 🔧 Development Commands

```bash
# Clean and rebuild
flutter clean && flutter pub get

# Run tests
flutter test

# Check for issues
flutter analyze

# Format code
flutter format .
```

## 📱 Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 👨‍💻 Author

**Kumarjit Hazra**
- GitHub: [@Kumarjit-Hazra](https://github.com/Kumarjit-Hazra)

---

## 📹 Video Walkthrough

Watch a quick walkthrough of the app in action here:
[https://www.loom.com/share/c28573f35b3c4c35be3c5c53b368806f](https://www.loom.com/share/c28573f35b3c4c35be3c5c53b368806f)


Made with ❤️ by  Kumarjit using Flutter

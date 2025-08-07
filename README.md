# The Startup Idea Evaluator 🚀

An AI-powered mobile application where users can submit, vote on, and share startup ideas.

## 🌟 Features Implemented

-   **Idea Submission Screen**: A user-friendly form to submit startup ideas with a name, tagline, and description.
-   **Fake AI-Generated Rating**: Each new idea gets a fun, fake AI-generated rating from 0 to 100.
-   **Idea Listing Screen**: A list of all submitted ideas, with the ability to:
    -   Upvote ideas (one vote per idea).
    -   Read the full description of each idea.
    -   Sort ideas by rating or by the number of votes.
-   **Leaderboard Screen**: A screen that displays the top 5 ideas, with badges for the top 3.
-   **Dark Mode**: A toggle switch to switch between light and dark modes.
-   **Toast Notifications**: Feedback messages for actions like submitting a new idea, upvoting an idea, or deleting an idea.
-   **Share Idea**: A share button to share startup ideas via other apps.
-   **Swipe to Delete**: Swipe to delete an idea from the list.
-   **Persistence**: All ideas and user votes are saved locally on the device.

## 🧑‍💻 Tech Stack

-   **Flutter & Dart**: The application is built using the Flutter framework and the Dart programming language.
-   **Provider**: For state management.
-   **shared\_preferences**: For local storage.
-   **fluttertoast**: for toast notifications.
-   **share\_plus**: for sharing content.
-   **Material Widgets**: The UI is built using Flutter's Material Design widgets.

## 🚀 How to Run Locally

1.  Clone the repository:
    ```bash
    git clone https://github.com/your-username/startup-idea-evaluator.git
    ```
2.  Install the dependencies:
    ```bash
    flutter pub get
    ```
3.  Run the app:
    ```bash
    flutter run
    ```

## 📱 How to Install the APK

You can find the debug APK in the `build/app/outputs/flutter-apk/` directory after running the app. You can also generate a release APK by running:

```bash
flutter build apk --release
```

You can then share the APK file via Google Drive, WeTransfer, or any other file-sharing service.

## 🎥 Video Walkthrough

[Link to your Loom/YouTube video walkthrough]

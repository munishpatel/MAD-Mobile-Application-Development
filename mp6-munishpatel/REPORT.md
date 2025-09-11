# MP Report

## Team

- Name: Munish Patel
- AID: A20544034

## Self-Evaluation Checklist

Tick the boxes (i.e., fill them with 'X's) that apply to your submission:

- [X] The app builds without error
- [X] I tested the app in at least one of the following platforms (check all
      that apply):
  - [X] iOS simulator / MacOS
  - [ ] Android emulator
- [X] There are at least 3 separate screens/pages in the app
- [X] There is at least one stateful widget in the app, backed by a custom model
      class using a form of state management
- [X] Some user-updateable data is persisted across application launches
- [X] Some application data is accessed from an external source and displayed in
      the app
- [X] There are at least 5 distinct unit tests, 5 widget tests, and 1
      integration test group included in the project

## Questionnaire

Answer the following questions, briefly, so that we can better evaluate your
work on this machine problem.

1. What does your app do?

   My app, `MoodMate`, helps users track their daily mood and write journal entries. It provides wellness insights based on their mood using external quotes from API, and saves all entries locally for future reflection.

2. What external data source(s) did you use? What form do they take (e.g.,
   RESTful API, cloud-based database, etc.)?

   I used the `ZenQuotes API`, which is a public RESTful API that delivers inspirational and motivational quotes. Each time a user visits the Insights page or taps "Refresh", the app sends an HTTP GET request to ZenQuotes and displays a randomly selected quote with its author.

   URL : "https://zenquotes.io/"

3. What additional third-party packages or libraries did you use, if any? Why?

   I used:
   - `provider` – for state management of mood entries.
   - `http` – to fetch quotes from external APIs.
   - `shared_preferences` – for persistent local storage to save journals.
   - `flutter_test` and `integration_test` – for testing the app. 
   These packages helped meet the project requirements for state management, data persistence, and testing.

4. What form of local data persistence did you use?

   I used `SharedPreferences` to store mood journal entries as a JSON-encoded list. This ensures data is retained between app sessions.

5. What workflow is tested by your integration test?

   The integration test verifies the full end-to-end user experience. It simulates launching the app, entering a mood and journal note, saving the entry, navigating to the journal page to confirm the entry appears, and then navigating to the Insights page to validate that a motivational quote is successfully fetched from the ZenQuotes API and displayed to the user.

## Summary and Reflection

In this machine problem, I designed and implemented a wellness-focused Flutter app, `MoodMate`, that helps users track their moods, reflect through journaling, and receive motivational insights via the `ZenQuotes API`. I structured the app around clean modularity using the `Provider` package for state management, and implemented persistent storage using `SharedPreferences` to meet all technical requirements. A key implementation decision was adding a fallback UI and error handling around API failures, as well as enhancing the integration test to include live API data validation. While I encountered challenges with macOS networking permissions, I learned how to configure `Info.plist` and entitlements correctly for Flutter ios and macos apps.

I enjoyed building MoodMate because it was both personally meaningful and technically enriching. It helped me solidify concepts in state management, API integration, testing, and cross-platform development. I particularly appreciated the open-ended nature of the project, which allowed creative freedom in design and feature development.

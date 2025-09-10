# MP Report

## Student information

- Name: Munish Patel
- AID: A20544034

## Self-Evaluation Checklist

Tick the boxes (i.e., fill them with 'X's) that apply to your submission:

- [X] The app builds without error
- [X] I tested the app in at least one of the following platforms (check all
      that apply):
  - [X] iOS simulator / MacOS
  - [ ] Android emulator
- [X] Users can register and log in to the server via the app
- [X] Session management works correctly; i.e., the user stays logged in after
      closing and reopening the app, and token expiration necessitates re-login
- [X] The game list displays required information accurately (for both active
      and completed games), and can be manually refreshed
- [X] A game can be started correctly (by placing ships, and sending an
      appropriate request to the server)
- [X] The game board is responsive to changes in screen size
- [X] Games can be started with human and all supported AI opponents
- [X] Gameplay works correctly (including ship placement, attacking, and game
      completion)

## Summary and Reflection

In this Battleships project, I emphasized modular design and a clear separation of responsibilities. Each screen—`LoginScreen`, `HomeScreen`, and `GamePage`—is organized into its own class, promoting both maintainability and readability. Session management is handled through a custom `SessionManager`, which leverages `shared_preferences` to store tokens and user data. I used the `http` package to handle API communication, adhering to `REST` principles and implementing token-based authentication. To enable real-time updates, I incorporated asynchronous techniques such as `FutureBuilder` and stateful widgets. The GamePage reflects live changes in board state based on player interactions and game progression. Additionally, I introduced dismissible widgets in the game list to allow users to easily forfeit active games.

I found it rewarding to work on the interplay between the UI, state management, and REST API integration. Designing a smooth experience across login, game setup, and gameplay was particularly satisfying. One of the more challenging aspects was managing the game board's state efficiently, especially while dealing with asynchronous data and avoiding redundant operations. In hindsight, being aware of the API’s limitations, like the lack of a token refresh mechanism which would have helped reduce time spent on debugging. Overall, this machine problem offered valuable hands-on experience with Flutter and asynchronous programming, solidifying core concepts of modern app development.
# MP Report

## Team

- Name(s): Munish Patel
- AID(s): A20544034

## Self-Evaluation Checklist

Tick the boxes (i.e., fill them with 'X's) that apply to your submission:

- [X] The app builds without error
- [X] I tested the app in at least one of the following platforms (check all that apply):
  - [X] iOS simulator / MacOS
  - [ ] Android emulator
- [X] Decks can be created, edited, and deleted
- [X] Cards can be created, edited, sorted, and deleted
- [X] Quizzes work correctly
- [X] Decks and Cards can be loaded from the JSON file
- [X] Decks and Cards are saved/loaded correctly from/to a SQLite database
- [X] The UI is responsive to changes in screen size

## Summary and Reflection

I built a multi-page flashcard application while correctly applying state management techniques and SQLite database functionality in Flutter. Modular project design used separate models for Deck and Flashcard alongside providers for state management and custom views designed for every screen thus preserving clear organization. The application benefits from responsive design to accommodate various screen sizes as well as it enables easier database management through SQLite integration with the sqflite package. The performance along with user-friendly interface of Provider as state manager made me select it for the current application complexity. The most difficult part of my development involved maintaining state updates between nested widgets particularly while changing the deck count display on the Deck List screen due to database modifications. I managed to effectively execute this complex component.

The app components remained synchronized through the state management pattern ChangeNotifier. The screen adaptation displayed by Flutter provided a pleasing viewing experience as the app updated to fit different resolutions and device orientations. The setup of sqflite along with implementing structured asynchronous operations proved challenging because it needed thorough debugging to address database operation errors. My understanding of database setup in Flutter needed improvement because it would have reduced my development time. Response-time updates of real-time state worked alongside persistent storage in an experience that delivered both excitement and learning challenges.

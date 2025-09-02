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
  - [X] Google Chrome
- [X] The dice rolling mechanism works correctly
- [X] The scorecard works correctly
- [X] Scores are correctly calculated for all categories
- [X] The game end condition is correctly implemented, and the final score is
      correctly displayed
- [X] The game state is reset when the user dismisses the final score
- [X] The implementation separates layout from data, involving the use of data
      model classes separate from custom widgets

## Summary and Reflection

The implementation of Yahtzee incorporated UI modularity through widget-based separation of `display_dice` and `display_scorecard`. I developed the `game_state` class that included functions to manage dice distributions along with scoring abilities and game management operations. The program implemented key features including its User interface alongside dice rolling logic and score selection mechanism and game completion rules before displaying the final score in an alert modal dialog. I encountered display problems with the widgets at first that I fixed through examination of the documentation.

The development process involved stateful widgets as well as state management to maintain ongoing efficiency. I found myself unclear about the game protocols because I was unfamiliar with its rules. Mastering state scoring demanded extensive effort before succeeding in proper functionality. Starting my machine problem (MP) later would have been ideal if I had discovered the game beforehand.
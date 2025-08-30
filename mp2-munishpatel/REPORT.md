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
  - [X] Google Chrome
  - [ ] Windows Edge
- [X] The page displays correctly in a window of at least 1024x768 pixels
- [X] The layout contains at least 4 distinct sections
- [X] The layout makes use of the required widgets
- [X] The page uses at least three images
- [X] The page utilizes at least one nested row/column widget
- [X] The implementation uses a data model class to represent user information

## Summary and Reflection

For this task, I have successfully incorporated all the requirements mentioned for the MP2:Profile Page. I ensured to maintain the data model independent of the UI widgets so as to have a clean and reusable code base. This profile page consists of various sections such as a UserProfileHeader, ContactInfo, EducationSection, and ProjectSection, each of which is built by utilizing Flutter's layout widgets. I have used GridView for ProjectSection with 3 columns per row, and images and text in cards. I have also used padding and alignment for education and contact sections to improve readability. I have also added background colors to each section to improve visibility. Finally, I have run the app on iOS simulator, Google Chrome and window of 1024x768 pixels. One of the biggest challenges i overcame was implementing responsive alignment and still having a clean, scrollable layout, but I managed to overcome those alignment problems.

It was fun working with Flutter's flexible layout system, especially with the GridView and Column widgets. It was difficult working with nested widgets and figuring out padding/margin. I would have liked, had I done it first, to understand better how Expanded and Flexible work with changes in the layout and more familiarly known to Flutter layout debug tools as they would have streamlined the process. Overall, it was worth learning.
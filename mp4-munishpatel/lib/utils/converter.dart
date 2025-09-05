import 'dart:convert';
import 'package:cs442_mp4/models/modeldeck.dart';
import 'package:cs442_mp4/models/flashcards.dart';
import 'package:cs442_mp4/utils/helper_db.dart';
import 'package:flutter/services.dart';


Future<void> insertJsonDataToDB() async {
  final db = DatabaseHelper.instance;
  final decksCount = await db.getDecks(); 

  if (decksCount == 0) {
    final jsonString = await rootBundle.loadString('assets/flashcards.json');
    final jsonData = json.decode(jsonString);

    for (var deckData in jsonData) {
      final deckTitle = deckData['title'];
      final flashcards = deckData['flashcards'];
      final int deckId = await db.insertDeck(Deck(title: deckTitle));

      for (var flashcardData in flashcards) {
        final String question = flashcardData['question'];
        final String answer = flashcardData['answer'];

        await db.insertFlashcard(Flashcard(
          question: question,
          answer: answer,
          deckId: deckId,
        ));
      }
    }
  }
}

Future<void> defaultinsertJsonDataToDB() async {
  final jsonString = await rootBundle.loadString('assets/flashcards.json');
  final jsonData = json.decode(jsonString);

  final db = DatabaseHelper.instance;

  for (var deckData in jsonData) {
    final deckTitle = deckData['title'];
    final flashcards = deckData['flashcards'];    
    final int deckId = await db.insertDeck(Deck(title: deckTitle));

    for (var flashcardData in flashcards) {
      final String question = flashcardData['question'];
      final String answer = flashcardData['answer'];

      await db.insertFlashcard(Flashcard(
        question: question,
        answer: answer,
        deckId: deckId,
      ));
    }
  }
}

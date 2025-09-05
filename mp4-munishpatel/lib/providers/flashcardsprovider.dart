import 'package:cs442_mp4/utils/helper_db.dart';
import 'package:flutter/material.dart';

import '../models/flashcards.dart';

class FlashcardProvider extends ChangeNotifier {
  List<Flashcard> _flashcards = [];

  FlashcardProvider();

  List<Flashcard> get flashcards => _flashcards;

 Future<List<Flashcard>> loadFlashcards(int deckId) async 
  {
    
    final dbHelper = DatabaseHelper.instance;
    final loadedflashcards = await dbHelper.loadFlashcards(deckId);
    _flashcards = loadedflashcards;
    notifyListeners();
    return _flashcards;
  }



  Future<void> insertFlashcard(Flashcard flashcard) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      await dbHelper.insertFlashcard(flashcard);
      await loadFlashcards(flashcard.deckId);
      print(flashcards.length);

      

      notifyListeners();
    } catch (error) {
      
      print('Error inserting flashcard: $error');
    }
  }

  void addFlashcard(Flashcard flashcard) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      await dbHelper.insertFlashcard(flashcard);
      _flashcards.add(flashcard);
      notifyListeners();
    } catch (error) {
      print('Error adding flashcard: $error');
    }
  }

  Future<void> updateFlashcard(Flashcard flashcard) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      final updatedRows = await dbHelper.updateFlashcard(flashcard);
      if (updatedRows > 0) {
        final index = _flashcards.indexWhere((element) => element.id == flashcard.id);
        if (index != -1) {
          _flashcards[index] = flashcard;
          notifyListeners();
        }
      } else {
        print('Failed to update flashcard.');
      }
    } catch (error) {
      print('Error updating flashcard: $error');
    }
  }

  Future<void> deleteFlashcard(int flashcardId) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      final deletedRows = await dbHelper.deleteFlashcard(flashcardId);
      if (deletedRows > 0) {
        _flashcards.removeWhere((flashcard) => flashcard.id == flashcardId);
        notifyListeners();
      } else {
        print('Failed to delete flashcard.');
      }
    } catch (error) {
      print('Error deleting flashcard: $error');
    }
  }

  Future<int> getNumberOfFlashcardsInDeck(int deckId) async {
    final dbHelper = DatabaseHelper.instance;
    final count = await dbHelper.getNumberOfFlashcardsInDeck(deckId);
    print(count);
    return count;
  }

  
}
        
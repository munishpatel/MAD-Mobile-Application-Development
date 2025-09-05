import 'package:cs442_mp4/models/modeldeck.dart';
import 'package:cs442_mp4/utils/helper_db.dart';
import 'package:flutter/foundation.dart';

class DeckProvider with ChangeNotifier {
  List<Deck> _decks = [];

  List<Deck> get decks => _decks;
  DeckProvider() {
    loadDecks();
  }

  
  void loadDecks() async {
    final dbHelper = DatabaseHelper.instance;
    final loadedDecks = await dbHelper.getDecks();
    _decks = loadedDecks;
    notifyListeners();
  }

  
  void addDeck(Deck deck) async {
    final dbHelper = DatabaseHelper.instance;
    final insertedDeckId = await dbHelper.insertDeck(deck);
    final newDeck = deck.copyWith(id: insertedDeckId);
    _decks.add(newDeck);
    notifyListeners();
  }

  
  void updateDeckTitle(Deck deck, String newTitle) async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.updateDeck(deck.copyWith(title: newTitle));
    final updatedDeckIndex = _decks.indexWhere((d) => d.id == deck.id);
    if (updatedDeckIndex != -1) {
      _decks[updatedDeckIndex] = deck.copyWith(title: newTitle);
      notifyListeners();
    }
  }

  
  void deleteDeck(int deckId) async {
    final dbHelper = DatabaseHelper.instance;

    
    _decks.removeWhere((deck) => deck.id == deckId);

    
    await dbHelper.deleteDeck(deckId);

    notifyListeners();
  }
}

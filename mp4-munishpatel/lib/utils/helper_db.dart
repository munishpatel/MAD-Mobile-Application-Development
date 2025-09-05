import 'package:cs442_mp4/models/modeldeck.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../models/flashcards.dart';

class DatabaseHelper {
  static const String _databaseName = 'flashcards.db';
  static const int _databaseVersion = 1;

  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }


  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final pathToDatabase = path.join(documentsDirectory.path, _databaseName);
    
    
    Database db = await openDatabase(pathToDatabase, version: _databaseVersion,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE deck (
          id INTEGER PRIMARY KEY,
          title TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE flashcards (
          id INTEGER PRIMARY KEY,
          question TEXT,
          answer TEXT,
          deckId INTEGER,
          FOREIGN KEY (deckId) REFERENCES decks(id)
        )
      ''');
    });
    return db;
  }
  Future<List<Deck>> getDecks() async {
    final Database db = await database;
    final List<Map<String, dynamic>> deckDataList = await db.query('deck');
    
    
    final List<Deck> decks = deckDataList.map((deckData) {
      return Deck(id: deckData['id'], title: deckData['title']);
    }).toList();

    return decks;
  }

  Future<int> insertDeck(Deck deck) async {
    final Database db = await database;
    return await db.insert('deck', {'title': deck.title});
  }


  Future<List<Flashcard>> loadFlashcards(int deckId) async {
    final Database db = await database;
    final flashcards = await db.query('flashcards', where: 'deckId = ?', whereArgs: [deckId]);

    List<Flashcard> _flashcards = flashcards.map((flashcardMap) {
      return Flashcard(
        id: flashcardMap['id'] as int,
        question: flashcardMap['question'] as String,
        answer: flashcardMap['answer'] as String,
        deckId: flashcardMap['deckId'] as int,
      );
    }).toList();

    return _flashcards;
  }

  Future<int> updateDeck(Deck deck) async {
  final Database db = await database;
  return await db.update('deck', {'title': deck.title}, where: 'id = ?', whereArgs: [deck.id]);
  }

  Future<void> deleteDeck(int deckId) async {
  final Database db = await database;
  await db.delete('deck', where: 'id = ?', whereArgs: [deckId]);
  await db.delete('flashcards', where: 'deckId = ?',whereArgs: [deckId]);
  
  }

  Future<void> insertFlashcard(Flashcard flashcard) async {
    final Database db = await database;
    await db.insert('flashcards', {
      'question': flashcard.question,
      'answer': flashcard.answer,
      'deckId': flashcard.deckId,
    });
  }
  
  Future<int> updateFlashcard(Flashcard flashcard) async {
    final Database db = await database;
    return await db.update('flashcards', {
      'question': flashcard.question,
      'answer': flashcard.answer,
    }, where: 'id = ?', whereArgs: [flashcard.id]);
  }

  Future<int> deleteFlashcard(int flashcardId) async {
    final Database db = await database;
    return await db.delete('flashcards', where: 'id = ?', whereArgs: [flashcardId]);
  }
  
  Future<int> getNumberOfFlashcardsInDeck(int deckId) async {
    final Database db = await database;
    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM flashcards WHERE deckId = ?', [deckId]),
    );
    return count ?? 0;
  }

  Future<void> clearDatabase() async {
    final Database db = await database;
    await db.delete('deck');
    await db.delete('flashcards');
  }
  
}


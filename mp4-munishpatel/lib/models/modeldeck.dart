import 'package:cs442_mp4/models/flashcards.dart';

class Deck {
  final int? id ;
  String title;
  final List<Flashcard>? flashcards;

  Deck({
    this.id,
    required this.title,
    this.flashcards,
  });

  factory Deck.fromJson(Map<String, dynamic> json) {
    var flashcardslist  = json['flashcards'] as List?;
    List<Flashcard>? flashcards;
    if (flashcardslist != null) {
      flashcards = flashcardslist.map((card) => Flashcard.fromJson(card)).toList();
    }

    return Deck(
      id: 0, 
      title: json['title'],
      flashcards: flashcards,
    );
  }

  Deck copyWith({
    int? id,
    String? title,
    List<Flashcard>? flashcards,
  }) {
    return Deck(
      id: id ?? this.id,
      title: title ?? this.title,
      flashcards: flashcards ?? this.flashcards,
    );
    
  }
  
}

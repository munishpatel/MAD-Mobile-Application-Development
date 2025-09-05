class Flashcard {
  final int? id;
  final String question;
  final String answer;
  final int deckId;
  bool peeked; 

  Flashcard({
    this.id,
    required this.question,
    required this.answer,
    required this.deckId,
    this.peeked = false, 
  });

  Flashcard copyWith({
    int? id,
    String? question,
    String? answer,
    int? deckId,
    bool? peeked, 
  }) {
    return Flashcard(
      id: id ?? this.id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      deckId: deckId ?? this.deckId,
      peeked: peeked ?? this.peeked, 
    );
  }

  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      id: 0, 
      question: json['question'],
      answer: json['answer'],
      deckId: 0, 
    );
  }
}

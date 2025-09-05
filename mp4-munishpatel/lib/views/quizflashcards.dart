import 'package:cs442_mp4/models/flashcards.dart';
import 'package:flutter/material.dart';


class QuizFlashcards extends StatefulWidget {
  final List<Flashcard> flashcards;

  QuizFlashcards({required this.flashcards});

  @override
  _QuizFlashcardsState createState() => _QuizFlashcardsState();
}

class _QuizFlashcardsState extends State<QuizFlashcards> {
  int currentViewIndex = 0;
  bool showAnswer = false;
  int peekCount = 0;
  int seenCount = 1;
  late List<bool> cardPeeked;
  late List<bool> cardSeen;

  @override
  void initState() {
    super.initState();
    widget.flashcards.shuffle();
    cardPeeked = List.generate(widget.flashcards.length, (index) => false);
    cardSeen = List.generate(widget.flashcards.length, (index) => false);
    cardSeen[0] = true;
  }

  @override
  Widget build(BuildContext context) {
    final flashcard = widget.flashcards[currentViewIndex];
    final cardColor = showAnswer ? Colors.green : Colors.blue[100];

    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcard Quiz'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 3,
              child: CardWidget(
                flashcard: flashcard,
                cardColor: cardColor,
                showAnswer: showAnswer,
              ),
            ),
            Flexible(
              flex: 1,
              child: SizedBox(height: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    showPreviousCard();
                  },
                ),
                PeekButton(
                  peeked: cardPeeked[currentViewIndex],
                  onPressed: showAnswer1,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    showNextCard();
                  },
                ),
              ],
            ),
            Flexible(
              flex: 1,
              child: SizedBox(height: 1),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text(
                  'Viewed $seenCount of ${widget.flashcards.length} cards\n\nPeeked at $peekCount of $seenCount answers',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAnswer1() {
    setState(() {
      showAnswer = !showAnswer;

      if (showAnswer) {
        if (cardPeeked[currentViewIndex] == false) {
          cardPeeked[currentViewIndex] = true;
          peekCount++;
        }
      }
    });
  }

  void showNextCard() {
    if (currentViewIndex < widget.flashcards.length - 1) {
      setState(() {
        currentViewIndex++;
        showAnswer = false;

        if (cardSeen[currentViewIndex] == false) {
          cardSeen[currentViewIndex] = true;
          seenCount++;
        }
      });
    } else {
      setState(() {
        currentViewIndex = 0;
        showAnswer = false;
      });
    }
  }

  void showPreviousCard() {
    if (currentViewIndex > 0) {
      setState(() {
        if (cardSeen[currentViewIndex] == false) {
          cardSeen[currentViewIndex] = true;
          seenCount++;
        }
        currentViewIndex--;
        showAnswer = false;
      });
    } else {
      setState(() {
        currentViewIndex = widget.flashcards.length - 1;
        if (cardSeen[currentViewIndex] == false) {
          cardSeen[currentViewIndex] = true;
          seenCount++;
        }
        showAnswer = false;
      });
    }
  }
}

class CardWidget extends StatelessWidget {
  final Flashcard flashcard;
  final Color? cardColor;
  final bool showAnswer;

  CardWidget({
    required this.flashcard,
    this.cardColor,
    required this.showAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 5,
      color: cardColor ?? Colors.white,
      child: Container(
        width: 400,
        height: 200, // Adjust the height
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            showAnswer ? flashcard.answer : flashcard.question,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              color: showAnswer ? Colors.black : const Color.fromARGB(255, 6, 7, 6),
            ),
          ),
        ),
      ),
    );
  }
}

class PeekButton extends StatelessWidget {
  final bool peeked;
  final VoidCallback onPressed;

  PeekButton({required this.peeked, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.visibility,
        color: peeked ? Colors.grey : null,
      ),
      onPressed: onPressed,
    );
  }
}

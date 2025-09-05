import 'package:cs442_mp4/views/editflashcards.dart';
import 'package:cs442_mp4/views/quizflashcards.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../models/flashcards.dart';
import '../providers/flashcardsprovider.dart';


class FlashcardList extends StatefulWidget {
  final int deckId;
  final String decktitle;

  FlashcardList({required this.deckId,required this.decktitle});

  @override
  _FlashcardListState createState() => _FlashcardListState();
}

class _FlashcardListState extends State<FlashcardList> {
  List<Flashcard>? flashcards;
  bool isSorting = false;

  @override
  void initState() {
    super.initState();
    loadFlashcards();
  }

  Future<void> loadFlashcards() async {
    List<Flashcard> loadedFlashcards =
        await Provider.of<FlashcardProvider>(context, listen: false)
            .loadFlashcards(widget.deckId);

    setState(() {
      flashcards = loadedFlashcards;
    });
  }

  @override
  Widget build(BuildContext context) {
    final flashcardProvider = Provider.of<FlashcardProvider>(context, listen: false);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.decktitle),
        actions: <Widget>[
          IconButton(
            icon: Icon(isSorting ? Icons.sort : Icons.sort_by_alpha),
            onPressed: () {
              setState(() {
                isSorting = !isSorting;
                if (isSorting) {
                  flashcards?.sort((a, b) {
                    // Custom sorting logic
                    final firstCharA = a.question.isNotEmpty ? a.question[0].toLowerCase() : '';
                    final firstCharB = b.question.isNotEmpty ? b.question[0].toLowerCase() : '';

                    // Compare the first characters and prioritize lowercase letters
                    return firstCharA.compareTo(firstCharB);
                  });
                } else {
                  // Revert to the original order
                  loadFlashcards();
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.play_circle_outline), // Icon for starting the quiz
            onPressed: () {
              if (flashcards != null && flashcards!.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizFlashcards(flashcards: flashcards!),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: flashcards == null
          ? Center(child: CircularProgressIndicator())
          : flashcards!.isEmpty
              ? Center(child: Text('No flashcards available.'))
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: mediaQuery.size.width <= 600 ? 200 : 300,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: flashcards?.length ?? 0,
                  itemBuilder: (context, index) {
                    final flashcard = flashcards![index];
                    return GestureDetector(
                      onTap: () async {
                        // Navigate to EditFlashcardPage for editing
                        final updatedFlashcard = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditFlashcardPage(
                              flashcard: flashcard,
                              onSave: (updatedFlashcard) async {
                                // Handle saving the updated flashcard
                                await flashcardProvider.updateFlashcard(updatedFlashcard);
                                loadFlashcards(); // Update the list
                              },
                              onDelete: (flashcardToDelete) async {
                                // Handle deleting the flashcard
                                await flashcardProvider.deleteFlashcard(flashcardToDelete.id ?? 0);
                                loadFlashcards(); // Update the list
                              },
                            ),
                          ),
                        );

                        if (updatedFlashcard != null) {
                          // Optionally, you can handle any other actions here if needed.
                        }
                      },
                      child: Card(
                        color: Colors.blue[100],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center, // Center flashcard name
                            children: [
                              Center(
                                child: Text(
                                  '${flashcard.question}',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFlashcardPage(deckId: widget.deckId),
            ),
          );

          if (result != null && result) {
            loadFlashcards();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


class AddFlashcardPage extends StatefulWidget {
  final int deckId;

  AddFlashcardPage({required this.deckId});

  @override
  _AddFlashcardPageState createState() => _AddFlashcardPageState();
}

class _AddFlashcardPageState extends State<AddFlashcardPage> {
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final flashcardProvider = Provider.of<FlashcardProvider>(context, listen: false);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Flashcard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: questionController,
              decoration: InputDecoration(labelText: 'Question'),
            ),
            SizedBox(height: mediaQuery.size.height * 0.02), // Add space between the fields
            TextField(
              controller: answerController,
              decoration: InputDecoration(labelText: 'Answer'),
            ),
            SizedBox(height: mediaQuery.size.height * 0.02), // Add space between the fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // Align buttons in a row
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle saving the question and answer
                    String question = questionController.text;
                    String answer = answerController.text;
                    flashcardProvider.insertFlashcard(Flashcard(question: question, answer: answer, deckId: widget.deckId));
                    Navigator.pop(context, true); // Close the AddFlashcardPage
                  },
                  child: Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle clearing the fields
                    questionController.clear();
                    answerController.clear();
                  },
                  child: Text('Clear'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

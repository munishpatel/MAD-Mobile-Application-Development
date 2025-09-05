import 'package:flutter/material.dart';
import '../models/flashcards.dart';

class EditFlashcardPage extends StatefulWidget {
  final Flashcard flashcard;
  final Function(Flashcard) onSave;
  final Function(Flashcard) onDelete;

  EditFlashcardPage({required this.flashcard, required this.onSave, required this.onDelete});

  @override
  _EditFlashcardPageState createState() => _EditFlashcardPageState();
}

class _EditFlashcardPageState extends State<EditFlashcardPage> {
  late TextEditingController questionController;
  late TextEditingController answerController;

  @override
  void initState() {
    super.initState();
    questionController = TextEditingController(text: widget.flashcard.question);
    answerController = TextEditingController(text: widget.flashcard.answer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Flashcard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: questionController,
              decoration: InputDecoration(labelText: 'Question'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: answerController,
              decoration: InputDecoration(labelText: 'Answer'),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Update and save the flashcard
                    String question = questionController.text;
                    String answer = answerController.text;
                    Flashcard updatedFlashcard = widget.flashcard.copyWith(
                      question: question,
                      answer: answer,
                    );
                    widget.onSave(updatedFlashcard);
                    Navigator.pop(context,true);
                  },
                  child: Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Delete the flashcard
                    widget.onDelete(widget.flashcard);
                    Navigator.pop(context);
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

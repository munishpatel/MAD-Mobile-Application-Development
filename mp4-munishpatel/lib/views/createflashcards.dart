import 'package:flutter/material.dart';

class AddFlashcardPage extends StatefulWidget {
  @override
  _AddFlashcardPageState createState() => _AddFlashcardPageState();
}

class _AddFlashcardPageState extends State<AddFlashcardPage> {
  final TextEditingController _questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Flashcard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _questionController,
              decoration: InputDecoration(labelText: 'Question'),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        children: [
          Expanded(
            child: FloatingActionButton(
              onPressed: () {
                // Save the flashcard (question) and navigate back to the previous page
                Navigator.pop(context, _questionController.text);
              },
              child: Icon(Icons.save),
            ),
          ),
          SizedBox(width: 16), // Add some spacing
          Expanded(
            child: FloatingActionButton(
              onPressed: () {
                // Delete the flashcard (question) and navigate back to the previous page
                Navigator.pop(context, true);
              },
              child: Icon(Icons.delete),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DeckCreateView extends StatefulWidget {
  final void Function(String) onSave;
  final VoidCallback onDelete;

  DeckCreateView({
    required this.onSave,
    required this.onDelete,
  });

  @override
  _DeckCreateViewState createState() => _DeckCreateViewState();
}

class _DeckCreateViewState extends State<DeckCreateView> {
  final TextEditingController _deckNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create or Edit Deck'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _deckNameController,
              decoration: InputDecoration(labelText: 'Deck Name'),
              onChanged: (newName) {
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                widget.onSave(_deckNameController.text);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                widget.onDelete();
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _deckNameController.dispose();
    super.dispose();
  }
}

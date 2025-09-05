import 'package:flutter/material.dart';


class DeckEditPage extends StatefulWidget {
  final String deckTitle;
  final void Function(String) onSave;
  final VoidCallback onDelete;

  DeckEditPage({
    required this.deckTitle,
    required this.onSave,
    required this.onDelete,
  });

  @override
  _DeckEditPageState createState() => _DeckEditPageState();
}

class _DeckEditPageState extends State<DeckEditPage> {
  late TextEditingController _deckNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _deckNameController = TextEditingController(text: widget.deckTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Deck'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _deckNameController,
              decoration: InputDecoration(labelText: 'Deck Name'),
              onChanged: (newName){
                
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final newName = _deckNameController.text;
                widget.onSave(newName);
                
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

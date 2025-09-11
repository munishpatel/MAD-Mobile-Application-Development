// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cs442_mp6/models/mood_entry.dart';
import 'package:cs442_mp6/providers/journal_provider.dart';
import 'package:cs442_mp6/pages/journal_page.dart';
import 'package:cs442_mp6/pages/insights_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _selectedMood;
  final TextEditingController _noteController = TextEditingController();

  void _submitEntry() {
    if (_selectedMood != null && _noteController.text.isNotEmpty) {
      final newEntry = MoodEntry(
        mood: _selectedMood!,
        note: _noteController.text,
        timestamp: DateTime.now(),
      );

      Provider.of<JournalProvider>(context, listen: false).addEntry(newEntry);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mood entry saved!')),
      );

      _noteController.clear();
      setState(() {
        _selectedMood = null;
      });
    }
  }

  Widget _buildMoodSelector(String moodEmoji, String label) {
    final isSelected = _selectedMood == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedMood = label),
      child: Column(
        children: [
          CircleAvatar(
            radius: isSelected ? 32 : 28,
            backgroundColor: isSelected ? Colors.teal : Colors.grey[300],
            child: Text(
              moodEmoji,
              style: TextStyle(fontSize: 28),
            ),
          ),
          SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MoodMate'),
        actions: [
          IconButton(
            icon: Icon(Icons.insights),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => InsightsPage()),
            ),
          ),
          IconButton(
            icon: Icon(Icons.book),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => JournalPage()),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'How are you feeling today?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMoodSelector('😊', 'Happy'),
                _buildMoodSelector('😐', 'Neutral'),
                _buildMoodSelector('😔', 'Sad'),
                _buildMoodSelector('😠', 'Angry'),
              ],
            ),
            SizedBox(height: 24),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                hintText: 'Write about your day...',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitEntry,
              child: Text('Save Entry'),
            ),
          ],
        ),
      ),
    );
  }
}

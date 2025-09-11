// lib/pages/journal_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cs442_mp6/providers/journal_provider.dart';
import 'package:cs442_mp6/models/mood_entry.dart';

class JournalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final entries = Provider.of<JournalProvider>(context).entries;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Journal'),
      ),
      body: entries.isEmpty
          ? Center(child: Text('No entries yet.'))
          : ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final MoodEntry entry = entries[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: Text(
                      _getEmoji(entry.mood),
                      style: TextStyle(fontSize: 28),
                    ),
                    title: Text(entry.note),
                    subtitle: Text(
                      '${entry.mood} • ${entry.timestamp.toLocal().toString().split('.')[0]}',
                      style: TextStyle(fontSize: 12),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        Provider.of<JournalProvider>(context, listen: false)
                            .deleteEntry(entry);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }

  String _getEmoji(String mood) {
    switch (mood) {
      case 'Happy':
        return '😊';
      case 'Neutral':
        return '😐';
      case 'Sad':
        return '😔';
      case 'Angry':
        return '😠';
      default:
        return '❓';
    }
  }
}

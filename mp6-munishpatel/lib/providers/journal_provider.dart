import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cs442_mp6/models/mood_entry.dart';

class JournalProvider extends ChangeNotifier {
  List<MoodEntry> _entries = [];

  List<MoodEntry> get entries => _entries;

  Future<void> loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('mood_entries');
    if (jsonString != null) {
      final List decoded = json.decode(jsonString);
      _entries = decoded.map((e) => MoodEntry.fromJson(e)).toList();
      notifyListeners();
    }
  }

  Future<void> saveEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = json.encode(_entries.map((e) => e.toJson()).toList());
    await prefs.setString('mood_entries', encoded);
  }

  void addEntry(MoodEntry entry) {
    _entries.insert(0, entry);
    saveEntries();
    notifyListeners();
  }

  void deleteEntry(MoodEntry entry) {
    _entries.remove(entry);
    saveEntries();
    notifyListeners();
  }
}
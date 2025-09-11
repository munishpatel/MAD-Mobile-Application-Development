import 'package:flutter_test/flutter_test.dart';
import 'package:cs442_mp6/models/mood_entry.dart';
import 'package:cs442_mp6/providers/journal_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('MoodEntry Model Tests', () {
    test('toJson returns correct map', () {
      final entry = MoodEntry(
        mood: 'Happy',
        note: 'Great day!',
        timestamp: DateTime.parse('2024-01-01T10:00:00Z'),
      );

      final map = entry.toJson();
      expect(map['mood'], 'Happy');
      expect(map['note'], 'Great day!');
      expect(map['timestamp'], '2024-01-01T10:00:00.000Z');
    });

    test('fromJson creates valid MoodEntry object', () {
      final json = {
        'mood': 'Sad',
        'note': 'Rough day',
        'timestamp': '2024-01-02T15:30:00.000Z',
      };

      final entry = MoodEntry.fromJson(json);
      expect(entry.mood, 'Sad');
      expect(entry.note, 'Rough day');
      expect(entry.timestamp, DateTime.parse('2024-01-02T15:30:00.000Z'));
    });
  });

  group('JournalProvider Logic Tests', () {
    late JournalProvider provider;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      provider = JournalProvider();
    });

    test('addEntry adds a new mood entry', () async {
      final entry = MoodEntry(
        mood: 'Neutral',
        note: 'Okay day',
        timestamp: DateTime.now(),
      );
      provider.addEntry(entry);
      expect(provider.entries.length, 1);
      expect(provider.entries.first.mood, 'Neutral');
    });

    test('deleteEntry removes the entry', () async {
      final entry = MoodEntry(
        mood: 'Angry',
        note: 'Annoying situation',
        timestamp: DateTime.now(),
      );
      provider.addEntry(entry);
      provider.deleteEntry(entry);
      expect(provider.entries.isEmpty, true);
    });

    test('loadEntries loads empty on fresh prefs', () async {
      await provider.loadEntries();
      expect(provider.entries, isEmpty);
    });
  });
}

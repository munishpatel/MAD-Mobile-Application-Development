// lib/models/mood_entry.dart

class MoodEntry {
  final String mood;
  final String note;
  final DateTime timestamp;

  MoodEntry({
    required this.mood,
    required this.note,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'mood': mood,
      'note': note,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory MoodEntry.fromJson(Map<String, dynamic> json) {
    return MoodEntry(
      mood: json['mood'],
      note: json['note'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}

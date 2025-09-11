import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cs442_mp6/pages/startup_page.dart';
import 'package:cs442_mp6/providers/journal_provider.dart';

void main() {
  runApp(MoodMateApp());
}

class MoodMateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JournalProvider()..loadEntries(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MoodMate',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StartupPage(),
      ),
    );
  }
}
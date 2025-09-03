import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/yahtzee.dart';
import 'models/game_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GameState(),
      child: const MaterialApp(
        title: 'Yahtzee',
        home: Scaffold(
          body: Yahtzee(),
        ),
      ),
    ),
  );
}

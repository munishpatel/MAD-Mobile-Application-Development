import 'package:flutter/material.dart';
import 'dice.dart';
import 'scorecard.dart';

class GameState extends ChangeNotifier {
  final Dice dice = Dice(5);
  final ScoreCard scoreCard = ScoreCard();
  int _rollCount = 0;
  int get rollCount => _rollCount;
  int totalScore = 0;

  
  void rollDice() {
    if (_rollCount < 3) {
      dice.roll();
      _rollCount++;
      notifyListeners();
    }
  }

  void resetRoll() {
    dice.clear();
    _rollCount = 0;
    notifyListeners();
  }

  void holdDie(int index) {
    dice.toggleHold(index);
    notifyListeners();
  }

  void selectScoreCategory(ScoreCategory category) {
    scoreCard.registerScore(category, dice.values);
    totalScore = scoreCard.total;
    resetRoll();
    notifyListeners();
  }

  bool get isGameComplete => scoreCard.completed;

  void resetGame() {
    scoreCard.clear();
    totalScore = 0;
    resetRoll();
    notifyListeners();
  }
}

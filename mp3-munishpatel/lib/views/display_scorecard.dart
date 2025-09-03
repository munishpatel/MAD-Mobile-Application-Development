import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';
import '../models/scorecard.dart';

class DisplayScoreCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);

    // Split the score categories into two lists
    final leftColumn = [
      ScoreCategory.ones,
      ScoreCategory.twos,
      ScoreCategory.threes,
      ScoreCategory.fours,
      ScoreCategory.fives,
      ScoreCategory.sixes,
    ];

    final rightColumn = ScoreCategory.values
        .where((category) => !leftColumn.contains(category))
        .toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Left column for Ones to Sixes
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: leftColumn.map((category) {
              return ListTile(
                title: Text(category.name),
                trailing: Text(
                  gameState.scoreCard[category]?.toString() ?? 'pick',
                  style: TextStyle(
                    fontSize: gameState.scoreCard[category] != null ? 18 : 14,
                    color: gameState.scoreCard[category] != null ? null : Colors.blue,
                  ),
                ),
                onTap: gameState.scoreCard[category] == null
                    ? () => gameState.selectScoreCategory(category)
                    : null,
              );
            }).toList(),
          ),
        ),
        // Right column for the remaining categories
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rightColumn.map((category) {
              return ListTile(
                title: Text(category.name),
                trailing: Text(
                  gameState.scoreCard[category]?.toString() ?? 'pick',
                  style: TextStyle(
                    fontSize: gameState.scoreCard[category] != null ? 18 : 14,
                    color: gameState.scoreCard[category] != null ? null : Colors.blue,
                  ),
                ),
                onTap: gameState.scoreCard[category] == null
                    ? () => gameState.selectScoreCategory(category)
                    : null,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

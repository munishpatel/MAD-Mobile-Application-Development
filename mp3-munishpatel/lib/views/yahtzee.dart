import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'display_dice.dart';
import 'display_scorecard.dart';
import '../models/game_state.dart';

class Yahtzee extends StatelessWidget {
  const Yahtzee({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);

    // If the game is complete, show the game over modal dialog
    if (gameState.isGameComplete) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Game Over'),
              content: Text('Your final score is: ${gameState.totalScore}'),
              actions: [
                TextButton(
                  onPressed: () {
                    gameState.resetGame();
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red, // Text color
                  ),
                  child: const Text('Play Again'),
                ),
              ],
            );
          },
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Yahtzee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DisplayDice(),
            
            // padding between DiceDisplay and Roll button
            const SizedBox(height: 20.0),

            ElevatedButton(
              onPressed: gameState.rollCount < 3 ? gameState.rollDice : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Background color
                foregroundColor: Colors.white, // Text color
              ),
              child: Text('Roll (${gameState.rollCount}/3)'),
            ),
            Expanded(
              child: DisplayScoreCard(),
            ),
            Text('Current score: ${gameState.totalScore}'),
          ],
        ),
      ),
    );
  }
}

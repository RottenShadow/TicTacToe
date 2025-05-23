// import 'package:flutter/foundation.dart';
import 'dart:math';

import '../game_logic/check_result.dart';

class GameLogic {
  GameLogic._();
  static final GameLogic instance = GameLogic._();
  factory GameLogic() => instance;

  CheckResult checkResult = CheckResult.instance;
  final double _overallDifficulty = 0.80; //Between 0 and 1

  int minimax({
    required List<List<String>> board,
    required bool isMaximizing,
    // 1 - Hard, 2 - Medium, 3 - Easy
    required int difficulty,
  }) {
    // Check for terminal states
    if (checkResult.checkWin(board, 'O')) return 1;
    if (checkResult.checkWin(board, 'X')) return -1;
    if (checkResult.checkDraw(board)) return 0;

    if (isMaximizing) {
      int bestScore = -1000;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j].isEmpty) {
            board[i][j] = 'O'; // AI's turn
            bestScore = max(
                bestScore,
                minimax(
                    board: board, isMaximizing: false, difficulty: difficulty));
            board[i][j] = ''; // Undo move
          }
        }
      }
      // Introduce randomness based on difficulty
      if (difficulty > 1) {
        double randomNumber =
            double.parse((Random().nextDouble()).toStringAsFixed(1));

        if (randomNumber >= _overallDifficulty - (difficulty / 10)) {
          // When The User is going to win act like it's a draw for easier difficulty
          if (bestScore == -1) {
            return 0;
          }
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j].isEmpty) {
            board[i][j] = 'X'; // Player's turn
            bestScore = min(
              bestScore,
              minimax(board: board, isMaximizing: true, difficulty: difficulty),
            );
            board[i][j] = ''; // Undo move
          }
        }
      }
      //debugPrint('Difficulty: ${difficulty}');
      return bestScore;
    }
  }
}

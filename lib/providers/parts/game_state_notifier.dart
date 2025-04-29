import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xo/game_logic/app_logic.dart';
import 'package:xo/game_logic/storage/history_box.dart';
import 'package:xo/game_logic/storage/model/game_base_model.dart';
import 'package:xo/game_logic/storage/model/history_hive_model.dart';
import 'package:xo/helper_widgets/alert_dialog.dart';
import 'package:xo/providers/game_providers.dart';

class GameStateNotifier extends StateNotifier<GameBaseModel> {
  GameStateNotifier({required GameBaseModel gameBaseModel})
      : super(gameBaseModel);
  final gameLogic = AppLogic.instance;
  final gameProviders = GameProviders.instance;

  int playerXScore = 0;
  int playerOScore = 0;
  bool isAIPlaying = false;

  void onCellTap(int row, int col, WidgetRef ref, BuildContext context,
      GameBaseModel gameBaseModel) {
    final board = ref.watch(gameProviders.boardProvider);
    final currentPlayer = ref.watch(gameProviders.currentPlayerProvider);
    final winner = ref.watch(gameProviders.winnerProvider);

    if (isAIPlaying) return;
    final boardNotifier = ref.read(gameProviders.boardProvider.notifier);
    final currentPlayerNotifier =
        ref.read(gameProviders.currentPlayerProvider.notifier);
    final winnerNotifier = ref.read(gameProviders.winnerProvider.notifier);

    if (board[row][col].isEmpty && winner.isEmpty) {
      final currentPlayerValue = currentPlayer;
      boardNotifier.updateBoard(row, col, currentPlayerValue);

      if (gameLogic.checkResult.checkWin(board, currentPlayerValue)) {
        winnerNotifier.updateWinner(currentPlayerValue);
        if (currentPlayerValue == 'X') {
          playerXScore++;
        } else {
          playerOScore++;
        }
        showGameAlertDialog(
          "Player $currentPlayerValue wins!",
          context,
          currentPlayerValue,
          () => gameLogic.checkResult.resetGame(currentPlayerValue, ref),
        );
        HistoryBox.setHistory(HistoryModelHive(
          playerXName: gameBaseModel.playerXName,
          playerOName: gameBaseModel.playerOName,
          winner: currentPlayerValue,
        ));
      } else if (gameLogic.checkResult.checkDraw(board)) {
        winnerNotifier.updateWinner('draw');
        showGameAlertDialog(
          "Draw!",
          context,
          "draw",
          () => gameLogic.checkResult.resetGame(currentPlayerValue, ref),
        );
        HistoryBox.setHistory(HistoryModelHive(
          playerXName: gameBaseModel.playerXName,
          playerOName: gameBaseModel.playerOName,
          winner: 'draw',
        ));
      } else {
        currentPlayerNotifier.togglePlayer();
        if (gameBaseModel.isAgainstAI && currentPlayerValue == 'X') {
          isAIPlaying = true;
          Future.delayed(const Duration(milliseconds: 500), () {
            if (context.mounted) {
              makeAIMove(boardNotifier, currentPlayerNotifier, winnerNotifier,
                  context, ref, gameBaseModel);
            }
            isAIPlaying = false;
          });
        }
      }
    }
  }

  void makeAIMove(boardNotifier, currentPlayerNotifier, winnerNotifier,
      BuildContext context, WidgetRef ref, GameBaseModel gameBaseModel) {
    final board = ref.watch(gameProviders.boardProvider);

    int bestScore = -1000;
    int bestMoveRow = -1;
    int bestMoveCol = -1;

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          board[i][j] = 'O';
          // 1 - Hard, 2 - Medium, 3 - Easy
          int score = gameLogic.minimax(
            board: board,
            isMaximizing: false,
            difficulty: gameBaseModel.difficulty,
          );
          board[i][j] = '';

          if (score > bestScore) {
            bestScore = score;
            bestMoveRow = i;
            bestMoveCol = j;
          }
        }
      }
    }

    if (bestMoveRow != -1 && bestMoveCol != -1) {
      boardNotifier.updateBoard(bestMoveRow, bestMoveCol, 'O');
      if (gameLogic.checkResult.checkWin(board, 'O')) {
        winnerNotifier.updateWinner('O');
        playerOScore++;
        HistoryBox.setHistory(HistoryModelHive(
          playerXName: gameBaseModel.playerXName,
          playerOName: gameBaseModel.playerOName,
          winner: gameBaseModel.playerOName,
        ));
        showGameAlertDialog(
          "AI Wins!",
          context,
          'O',
          () => gameLogic.checkResult.resetGame('O', ref),
        );
      } else if (gameLogic.checkResult.checkDraw(board)) {
        winnerNotifier.updateWinner('draw');
        showGameAlertDialog("Draw!", context, 'draw',
            () => gameLogic.checkResult.resetGame('draw', ref));
      } else {
        currentPlayerNotifier.togglePlayer();
      }
    }
  }
}

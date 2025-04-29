import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xo/game_logic/game_logic.dart';
import 'package:xo/game_logic/storage/history_box.dart';
import 'package:xo/game_logic/storage/model/game_base_model.dart';
import 'package:xo/game_logic/storage/model/history_hive_model.dart';
import 'package:xo/helper_widgets/alert_dialog.dart';
import 'package:xo/providers/game_providers.dart';

class GameStateNotifier extends StateNotifier<GameBaseModel> {
  GameStateNotifier({required GameBaseModel gameBaseModel})
      : super(gameBaseModel);
  final gameLogic = GameLogic.instance;
  final gameProviders = GameProviders.instance;

  int playerXScore = 0;
  int playerOScore = 0;
  bool isAIPlaying = false;

  /// Handles the tap action on a cell in the game board.
  ///
  /// [row] and [col] specify the position of the tapped cell.
  /// [ref] is used to read and watch providers.
  /// [context] is the BuildContext of the widget.
  /// [gameBaseModel] contains the game's base information.
  ///

  void onCellTap({
    required int row,
    required int col,
    required WidgetRef ref,
    required BuildContext context,
    required GameBaseModel gameBaseModel,
  }) {
    final List<List<String>> board = ref.watch(gameProviders.boardProvider);
    final String currentPlayer = ref.watch(gameProviders.currentPlayerProvider);
    final String winner = ref.watch(gameProviders.winnerProvider);

    if (isAIPlaying) return;
    final boardNotifier = ref.read(gameProviders.boardProvider.notifier);
    final currentPlayerNotifier =
        ref.read(gameProviders.currentPlayerProvider.notifier);
    final winnerNotifier = ref.read(gameProviders.winnerProvider.notifier);

    if (board[row][col].isEmpty && winner.isEmpty) {
      final String currentPlayerValue = currentPlayer;
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
              makeAIMove(
                context: context,
                ref: ref,
                gameBaseModel: gameBaseModel,
              );
            }
            isAIPlaying = false;
          });
        }
      }
    }
  }

  /// Makes a move for the AI player.
  ///
  /// This function updates the board at the best move location
  /// and updates the winner and current player accordingly.
  ///
  /// [boardNotifier] is the provider for the current state of the board.
  /// [currentPlayerNotifier] is the provider for the current player.
  /// [winnerNotifier] is the provider for the winner of the game.
  /// [context] is the BuildContext of the widget.
  /// [ref] is the WidgetRef that provides access to the providers.
  /// [gameBaseModel] is the GameBaseModel that contains the game settings.
  ///

  void makeAIMove({
    // required BoardNotifier boardNotifier,
    // required CurrentPlayerNotifier currentPlayerNotifier,
    // required WinnerNotifier winnerNotifier,
    required BuildContext context,
    required WidgetRef ref,
    required GameBaseModel gameBaseModel,
  }) {
    final board = ref.watch(gameProviders.boardProvider);
    final boardNotifier = ref.read(gameProviders.boardProvider.notifier);
    final currentPlayerNotifier =
        ref.read(gameProviders.currentPlayerProvider.notifier);
    final winnerNotifier = ref.read(gameProviders.winnerProvider.notifier);

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

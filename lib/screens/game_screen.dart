import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../game_logic/app_logic.dart';
import '../game_logic/storage/model/history_hive_model.dart';
import '../providers/game_providers.dart';
import '../game_logic/storage/history_box.dart';
import '../theme/app_colors.dart';
import '../helper_widgets/alert_dialog.dart';
import '../helper_widgets/scoreboard.dart';
import '../helper_widgets/gradient_container.dart';

int playerXScore = 0;
int playerOScore = 0;
bool isAIPlaying = false;

class GameScreen extends ConsumerStatefulWidget {
  final String playerXName;
  final String playerOName;
  final int difficulty;
  final bool isAgainstAI;

  const GameScreen({
    super.key,
    required this.playerXName,
    required this.playerOName,
    required this.difficulty,
    required this.isAgainstAI,
  });

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  @override
  void dispose() {
    playerXScore = 0;
    playerOScore = 0;
    isAIPlaying = false;
    debugPrint('GameScreen Closed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameLogic = AppLogic();
    final board = ref.watch(boardProvider);
    final currentPlayer = ref.watch(currentPlayerProvider);
    final winner = ref.watch(winnerProvider);

    void makeAIMove(boardNotifier, currentPlayerNotifier, winnerNotifier,
        BuildContext context) {
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
              difficulty: widget.difficulty,
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
            playerXName: widget.playerXName,
            playerOName: widget.playerOName,
            winner: widget.playerOName,
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

    void onCellTap(int row, int col) {
      if (isAIPlaying) return;
      final boardNotifier = ref.read(boardProvider.notifier);
      final currentPlayerNotifier = ref.read(currentPlayerProvider.notifier);
      final winnerNotifier = ref.read(winnerProvider.notifier);

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
            playerXName: widget.playerXName,
            playerOName: widget.playerOName,
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
            playerXName: widget.playerXName,
            playerOName: widget.playerOName,
            winner: 'draw',
          ));
        } else {
          currentPlayerNotifier.togglePlayer();
          if (widget.isAgainstAI && currentPlayerValue == 'X') {
            isAIPlaying = true;
            Future.delayed(const Duration(milliseconds: 500), () {
              if (context.mounted) {
                makeAIMove(boardNotifier, currentPlayerNotifier, winnerNotifier,
                    context);
              }
              isAIPlaying = false;
            });
          }
        }
      }
    }

    return Scaffold(
      body: GradientContainer(
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - kToolbarHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: ScoreBoard(
                      playerXName: widget.playerXName,
                      playerOName: widget.playerOName,
                      playerXScore: playerXScore,
                      playerOScore: playerOScore,
                      isTurn: currentPlayer == 'X',
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 6,
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      child: GridView.builder(
                        padding: const EdgeInsets.all(5.0),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemBuilder: (context, index) {
                          int row = index ~/ 3;
                          int col = index % 3;

                          return GestureDetector(
                            onTap: () {
                              if (!isAIPlaying) {
                                onCellTap(row, col);
                              }
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: AppColors.kCell,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  board[row][col],
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontFamily: 'PermanentMarker',
                                    fontWeight: FontWeight.bold,
                                    color: board[row][col] == 'X'
                                        ? AppColors.kXColor
                                        : AppColors.kOColor,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: 9,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

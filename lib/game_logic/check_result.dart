import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/game_providers.dart';

class CheckResult {
  static final instance = CheckResult._();
  CheckResult._();
  factory CheckResult() => instance;

  bool checkWin(List<List<String>> board, String player) {
    for (int i = 0; i < 3; i++) {
      if ((board[i][0] == player &&
              board[i][1] == player &&
              board[i][2] == player) ||
          (board[0][i] == player &&
              board[1][i] == player &&
              board[2][i] == player)) {
        return true;
      }
    }
    if ((board[0][0] == player &&
            board[1][1] == player &&
            board[2][2] == player) ||
        (board[0][2] == player &&
            board[1][1] == player &&
            board[2][0] == player)) {
      return true;
    }
    return false;
  }

  bool checkDraw(List<List<String>> board) =>
      board.every((row) => row.every((cell) => cell.isNotEmpty));

  void resetGame(String currentPlayerValue, WidgetRef ref) {
    var gameProviders = GameProviders.instance;
    final boardNotifier = ref.read(gameProviders.boardProvider.notifier);
    final winnerNotifier = ref.read(gameProviders.winnerProvider.notifier);

    boardNotifier.resetBoard();
    // 'X always goes first';

    ref
        .read(gameProviders.currentPlayerProvider.notifier)
        .setPlayer(value: 'X');

    winnerNotifier.updateWinner('');
  }
}

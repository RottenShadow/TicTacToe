import 'package:hooks_riverpod/hooks_riverpod.dart';

class BoardNotifier extends StateNotifier<List<List<String>>> {
  BoardNotifier() : super(List.generate(3, (_) => List.filled(3, '')));

  void resetBoard() {
    state = List.generate(3, (_) => List.filled(3, ''));
  }

  void updateBoard(int row, int col, String value) {
    state[row][col] = value;
  }
}

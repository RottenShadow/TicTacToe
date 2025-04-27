import 'package:hooks_riverpod/hooks_riverpod.dart';

class CurrentPlayerNotifier extends StateNotifier<String> {
  CurrentPlayerNotifier() : super('X');

  void togglePlayer() {
    state = state == 'X' ? 'O' : 'X';
  }

  void setPlayer({required String value}) {
    state = value;
  }
}

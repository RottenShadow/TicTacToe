import 'package:hooks_riverpod/hooks_riverpod.dart';

class WinnerNotifier extends StateNotifier<String> {
  WinnerNotifier() : super('');

  void updateWinner(String value) {
    state = value;
  }
}

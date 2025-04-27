import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'parts/board_notifier.dart';
import 'parts/current_player_notifier.dart';
import 'parts/winner_notifier.dart';

final boardProvider = StateNotifierProvider<BoardNotifier, List<List<String>>>(
  (ref) => BoardNotifier(),
);
final currentPlayerProvider =
    StateNotifierProvider<CurrentPlayerNotifier, String>(
  (ref) => CurrentPlayerNotifier(),
);
final winnerProvider = StateNotifierProvider<WinnerNotifier, String>(
  (ref) => WinnerNotifier(),
);

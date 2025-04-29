import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../game_logic/storage/model/game_base_model.dart';
import 'parts/board_notifier.dart';
import 'parts/current_player_notifier.dart';
import 'parts/game_state_notifier.dart';
import 'parts/winner_notifier.dart';

class GameProviders {
  GameProviders._();
  static final instance = GameProviders._();
  factory GameProviders() => instance;

  final boardProvider =
      StateNotifierProvider<BoardNotifier, List<List<String>>>(
    (ref) => BoardNotifier(),
  );

  final currentPlayerProvider =
      StateNotifierProvider<CurrentPlayerNotifier, String>(
    (ref) => CurrentPlayerNotifier(),
  );
  final winnerProvider = StateNotifierProvider<WinnerNotifier, String>(
    (ref) => WinnerNotifier(),
  );

  final gameStateProvider = StateNotifierProvider.family<GameStateNotifier,
      GameBaseModel, GameBaseModel>((ref, gameBaseModel) {
    return GameStateNotifier(gameBaseModel: gameBaseModel);
  });
}

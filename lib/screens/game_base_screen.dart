import 'package:flutter/material.dart';
import 'package:xo/game_logic/app_logic.dart';
import 'package:xo/theme/app_colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../helper_widgets/history_modal.dart';
import 'game_screen.dart';

List<String> difficultyTitle = [
  '', //Hotfix for index 0
  'Hard',
  'Medium',
  'Easy',
];

class GameBaseScreen extends HookConsumerWidget {
  const GameBaseScreen({
    super.key,
    required this.isAgainstAI,
    this.difficulty = 2,
    required this.playerXName,
    required this.playerOName,
  });

  final String playerXName;
  final String playerOName;
  final int difficulty;
  final bool isAgainstAI;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLogic gameLogic = AppLogic();

    return Scaffold(
      appBar: AppBar(
        title: isAgainstAI
            ? Text(difficultyTitle[difficulty])
            : const Text('2 Players'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            gameLogic.checkResult.resetGame('X', ref);
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: AppColors.kWhitish,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              buildHistoryBottomSheet(context);
            },
            icon: const Icon(
              Icons.history_outlined,
              color: AppColors.kWhitish,
            ),
          ),
        ],
      ),
      body: GameScreen(
        playerXName: playerXName,
        playerOName: playerOName,
        isAgainstAI: isAgainstAI,
        difficulty: difficulty,
      ),
    );
  }
}

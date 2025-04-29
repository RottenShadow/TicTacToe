import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xo/game_logic/storage/model/game_base_model.dart';

import '../../providers/game_providers.dart';
import '../../theme/app_colors.dart';
import '../../helper_widgets/scoreboard.dart';
import '../../helper_widgets/gradient_container.dart';

class GameScreenBody extends ConsumerStatefulWidget {
  final GameBaseModel gameBaseModel;

  const GameScreenBody({
    super.key,
    required this.gameBaseModel,
  });

  @override
  ConsumerState<GameScreenBody> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreenBody> {
  @override
  void dispose() {
    debugPrint('GameScreen Closed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameProviders = GameProviders.instance;
    final board = ref.watch(gameProviders.boardProvider);
    final currentPlayer = ref.watch(gameProviders.currentPlayerProvider);
    final _winner =
        ref.watch(gameProviders.winnerProvider); // Needed only for ui rebuild
    final gameState = ref
        .watch(gameProviders.gameStateProvider(widget.gameBaseModel).notifier);

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
                      playerXName: widget.gameBaseModel.playerXName,
                      playerOName: widget.gameBaseModel.playerOName,
                      playerXScore: gameState.playerXScore,
                      playerOScore: gameState.playerOScore,
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
                              if (!gameState.isAIPlaying) {
                                gameState.onCellTap(
                                  context: context,
                                  ref: ref,
                                  row: row,
                                  col: col,
                                  gameBaseModel: widget.gameBaseModel,
                                );
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

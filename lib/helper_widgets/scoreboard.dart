import 'package:flutter/material.dart';
import 'package:xo/theme/app_sizes.dart';

import '../theme/app_colors.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({
    super.key,
    required this.playerXScore,
    required this.playerOScore,
    required this.isTurn,
    required this.playerXName,
    required this.playerOName,
  });

  final int playerXScore;
  final int playerOScore;
  final bool isTurn;
  final String playerXName;
  final String playerOName;

  Widget _buildPlayerScore(String playerLabel, int score, bool isTurn) =>
      Container(
        padding: const EdgeInsets.all(16),
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.kForeground,
          borderRadius: borderRadiusMedium(),
          border: isTurn
              ? playerLabel == playerXName
                  ? Border.all(
                      color: AppColors.kXColor,
                      width: 2.0,
                    )
                  : Border.all(
                      color: AppColors.kOColor,
                      width: 2.0,
                    )
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              playerLabel,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: playerLabel == playerXName
                    ? AppColors.kXColor
                    : AppColors.kOColor,
              ),
            ),
            Text(
              score.toString(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.kWhitish,
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildPlayerScore(playerXName, playerXScore, isTurn),
          _buildPlayerScore(playerOName, playerOScore, !isTurn),
        ],
      );
}

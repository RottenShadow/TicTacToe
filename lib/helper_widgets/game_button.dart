import 'package:flutter/material.dart';
import 'package:xo/theme/app_sizes.dart';

import '../theme/app_colors.dart';

class GameButton extends StatelessWidget {
  const GameButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isEnabled = true,
    this.color = "Default",
  });

  final void Function() onPressed;
  final String text;
  final String color;
  final bool isEnabled;

  Color getColor(String winner) {
    final colorMap = {
      false: AppColors.kGrey,
      'Default': AppColors.kForeground,
      'draw': AppColors.kDrawColor,
      'X': AppColors.kXColor,
      'O': AppColors.kOColor,
    };

    return colorMap[winner] ?? AppColors.kForeground;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        isEnabled ? onPressed() : null;
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: getColor(color),
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadiusMedium(),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isEnabled ? AppColors.kWhitish : Colors.black,
        ),
      ),
    );
  }
}

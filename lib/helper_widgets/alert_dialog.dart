import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'button_widget.dart';

void showGameAlertDialog(
    String message, BuildContext context, String winner, Function resetGame) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.kLighterForeground,
        elevation: 0,
        title: const Text(
          "Game Over",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        actions: [
          CustomButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetGame();
            },
            color: winner,
            text: 'Play Again',
          ),
        ],
      );
    },
  );
}

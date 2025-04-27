import 'package:flutter/material.dart';
import 'package:xo/screens/difficulty_screen.dart';
import 'package:xo/screens/game_base_screen.dart';
import 'package:xo/theme/app_sizes.dart';
import 'package:xo/theme/app_colors.dart';

import '../helper_widgets/gradient_container.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Tic Tac Toe',
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: "TechnoRace",
                  color: Colors.white,
                ),
              ),
              gapLarge(),
              MainMenuButtons(
                btnText: '1  Player',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DifficultyScreen(),
                    ),
                  );
                },
              ),
              gapMedium(),
              MainMenuButtons(
                btnText: '2  Players',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameBaseScreen(
                        playerXName: 'Player X',
                        playerOName: 'Player O',
                        isAgainstAI: false,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainMenuButtons extends StatelessWidget {
  const MainMenuButtons(
      {super.key, required this.btnText, required this.onPressed});

  final String btnText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.kForeground,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            btnText,
            style: const TextStyle(
              color: AppColors.kWhitish,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}

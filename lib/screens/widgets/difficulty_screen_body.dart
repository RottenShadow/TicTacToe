import 'package:flutter/material.dart';
import 'package:xo/helper_widgets/gradient_container.dart';

import '../../theme/app_sizes.dart';
import '../game_base_screen.dart';
import '../main_menu.dart';

class DifficultyScreenBody extends StatelessWidget {
  const DifficultyScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ai Difficulty',
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
              ),
            ),
            gapLarge(),
            MainMenuButtons(
              btnText: 'Easy',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameBaseScreen(
                      playerOName: "AI",
                      playerXName: "You",
                      isAgainstAI: true,
                      difficulty: 3,
                    ),
                  ),
                );
              },
            ),
            gapMedium(),
            MainMenuButtons(
              btnText: 'Medium',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameBaseScreen(
                      playerOName: "AI",
                      playerXName: "You",
                      isAgainstAI: true,
                      difficulty: 2,
                    ),
                  ),
                );
              },
            ),
            gapMedium(),
            MainMenuButtons(
              btnText: 'Hard',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameBaseScreen(
                      playerOName: "AI",
                      playerXName: "You",
                      isAgainstAI: true,
                      difficulty: 1,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

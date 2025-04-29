import 'package:flutter/material.dart';
import 'package:xo/game_logic/storage/model/game_base_model.dart';
import 'package:xo/helper_widgets/gradient_container.dart';

import '../../theme/app_sizes.dart';
import '../game_screen.dart';
import 'main_menu_buttons.dart';

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
            MenuButtons(
              btnText: 'Easy',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      var gameBaseModel = GameBaseModel.isAgainstAI(
                        isAgainstAI: true,
                        difficulty: 3,
                      );
                      return GameScreen(
                        gameBaseModel: gameBaseModel,
                      );
                    },
                  ),
                );
              },
            ),
            gapMedium(),
            MenuButtons(
              btnText: 'Medium',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      var gameBaseModel = GameBaseModel.isAgainstAI(
                        isAgainstAI: true,
                        difficulty: 2,
                      );
                      return GameScreen(
                        gameBaseModel: gameBaseModel,
                      );
                    },
                  ),
                );
              },
            ),
            gapMedium(),
            MenuButtons(
              btnText: 'Hard',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      var gameBaseModel = GameBaseModel.isAgainstAI(
                        isAgainstAI: true,
                        difficulty: 1,
                      );
                      return GameScreen(
                        gameBaseModel: gameBaseModel,
                      );
                    },
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

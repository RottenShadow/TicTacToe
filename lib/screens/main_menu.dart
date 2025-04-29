import 'package:flutter/material.dart';
import 'package:xo/game_logic/storage/model/game_base_model.dart';
import 'package:xo/screens/difficulty_screen.dart';
import 'package:xo/screens/game_screen.dart';
import 'package:xo/theme/app_sizes.dart';

import '../helper_widgets/gradient_container.dart';
import 'widgets/main_menu_buttons.dart';

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
              MenuButtons(
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
              MenuButtons(
                btnText: '2  Players',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        var gameBaseModel =
                            GameBaseModel.isAgainstAI(isAgainstAI: false);
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
      ),
    );
  }
}

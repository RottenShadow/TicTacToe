import 'package:flutter/material.dart';
import 'widgets/difficulty_screen_body.dart';

class DifficultyScreen extends StatelessWidget {
  const DifficultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DifficultyScreenBody(),
    );
  }
}

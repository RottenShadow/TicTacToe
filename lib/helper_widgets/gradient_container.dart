import 'package:flutter/material.dart';
import 'package:xo/theme/app_colors.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.kGradient1,
            AppColors.kGradient2,
          ],
          stops: [0.5, 0.8],
        ),
      ),
      child: child,
    );
  }
}

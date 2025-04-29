import 'package:flutter/material.dart';
import 'package:xo/theme/app_colors.dart';

class MenuButtons extends StatelessWidget {
  const MenuButtons(
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

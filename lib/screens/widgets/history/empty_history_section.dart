import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class EmptyHistorySection extends StatelessWidget {
  const EmptyHistorySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No game history !',
        style: TextStyle(
          fontSize: 20,
          color: AppColors.kWhitish,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

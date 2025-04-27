import 'package:flutter/material.dart';
import 'package:xo/game_logic/storage/model/history_hive_model.dart';
import 'package:xo/screens/widgets/history/empty_history_section.dart';
import 'package:xo/game_logic/storage/history_box.dart';
import 'package:xo/theme/app_colors.dart';

import 'widgets/history/history_found_section.dart';

class HistoryListScreen extends StatelessWidget {
  const HistoryListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<HistoryModelHive> historyList = HistoryBox.getHistory();

    historyList.sort((a, b) => b.date.compareTo(a.date));
    return Scaffold(
      backgroundColor: AppColors.kLighterForeground,
      body: historyList.isEmpty
          ? EmptyHistorySection()
          : HistoryFoundSection(historyList: historyList),
    );
  }
}

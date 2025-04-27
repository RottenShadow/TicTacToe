import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xo/theme/app_sizes.dart';

import '../../../helper_widgets/button_widget.dart';
import '../../../game_logic/storage/model/history_hive_model.dart';
import '../../../game_logic/storage/history_box.dart';
import '../../../theme/app_colors.dart';

class HistoryFoundSection extends StatelessWidget {
  const HistoryFoundSection({
    super.key,
    required this.historyList,
  });

  final List<HistoryModelHive> historyList;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: CustomButton(
              text: 'Clear History!',
              color: 'draw',
              onPressed: () {
                HistoryBox.clearHistory();
                Navigator.pop(context);
              },
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(51),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: 10,
                      decoration: BoxDecoration(
                        color: historyList[index].winner == 'X'
                            ? AppColors.kXColor
                            : historyList[index].winner == 'draw'
                                ? AppColors.kGrey
                                : AppColors.kOColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          bottomLeft: Radius.circular(50),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 30),
                        child: Column(
                          children: [
                            Text(
                              DateFormat('MMM d, y HH:mm')
                                  .format(historyList[index].date.toLocal()),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w100,
                                color: Colors.black,
                              ),
                            ),
                            gapSmall(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  historyList[index].playerXName,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.kXColor,
                                  ),
                                ),
                                const Text(
                                  "VS",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  historyList[index].playerOName,
                                  style: const TextStyle(
                                    color: AppColors.kOColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            childCount: historyList.length,
          ),
        ),
      ],
    );
  }
}

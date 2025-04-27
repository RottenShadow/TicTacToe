import 'package:flutter/material.dart';
import 'package:xo/screens/history_list_screen.dart';

void buildHistoryBottomSheet(BuildContext context) {
  showModalBottomSheet<void>(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15.0),
      ),
    ),
    elevation: 0,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return const SizedBox(
        height: 500,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: HistoryListScreen(),
        ),
      );
    },
  );
}

import 'package:flutter/material.dart';
import 'package:xo/game_logic/storage/model/history_hive_model.dart';
import 'package:xo/game_logic/storage/history_box.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(HistoryModelHiveAdapter());
  await HistoryBox.openBox();

  runApp(TicTacToeApp());
}

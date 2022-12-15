import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/constants/app_colors.dart';
import 'package:habit_tracker_flutter/persistence/hive_data_store.dart';
import 'package:habit_tracker_flutter/ui/home/home_page.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

import 'models/task.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppAssets.preloadSVGs();
  final dataStore = HiveDataStore();
  await dataStore.init();
  await dataStore.createDemoTasks(
    tasks: [
      Task.create(name: 'Do Karate', iconName: AppAssets.karate),
      Task.create(name: 'Go Running', iconName: AppAssets.run),
      Task.create(name: 'Go Swimming', iconName: AppAssets.swimmer),
      Task.create(name: 'Do Some Stretches', iconName: AppAssets.stretching),
      Task.create(name: 'Play Sports', iconName: AppAssets.basketball),
      Task.create(name: 'Spend Time Outside', iconName: AppAssets.sun),
    ],
    force: false,
  );
  runApp(ProviderScope(
    overrides: [
      dataStoreProvider.overrideWithValue(dataStore),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Helvetica Neue',
      ),
      home: AppTheme(
        data: AppThemeData.defaultWithSwatch(AppColors.red),
        child: HomePage(),
      ),
    );
  }
}

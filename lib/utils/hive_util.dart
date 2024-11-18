import 'package:blue_tine_interpreted_components/interfaces/data/duration.g.dart';
import 'package:blue_tine_interpreted_components/interfaces/data/enums/routine_status.dart';
import 'package:blue_tine_interpreted_components/interfaces/data/time_of_day.g.dart';
import 'package:blue_tine_interpreted_components/plugins/plugin.enum.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum HiveName { settings, plugin, routine, step, routineData, stepData }

extension HiveNameExt on HiveName {
  String plugin(PluginEnum plugin) {
    return '${plugin.name}_$name';
  }
}

enum HiveKey { authData, language, size, theme, useSystemTheme, installedPlugins }

abstract class HiveUtil {
  static Future<void> init() async {
    await Hive.initFlutter();

    final Box settings = await Hive.openBox(HiveName.settings.name);

    if (settings.isEmpty) {
      await settings.put(HiveKey.theme.name, ThemeMode.system.name);
    }

    Hive.registerAdapter(RoutineStatusAdapter());
    Hive.registerAdapter(PluginEnumAdapter());
    Hive.registerAdapter(DurationAdapter());
    Hive.registerAdapter(TimeOfDayAdapter());
  }
}


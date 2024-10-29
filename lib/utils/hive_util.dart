import 'package:blue_tine_interpreted_components/interfaces/data/duration.g.dart';
import 'package:blue_tine_interpreted_components/interfaces/data/enums/routine_status.dart';
import 'package:blue_tine_interpreted_components/interfaces/data/time_of_day.g.dart';
import 'package:blue_tine_interpreted_components/plugins/plugin.enum.dart';
import 'package:blue_tine_interpreted_components/utils/_utils.export.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Constant names for all hive boxes
enum HiveName { settings, plugin, routine, step, routineData, stepData }

extension HiveNameExt on HiveName {
  String plugin(PluginEnum plugin) {
    return '${plugin.name}_$name';
  }
}

/// Identifier for "singleton-like" values in certain boxes
enum HiveKey { authData, language, size, theme, useSystemTheme, installedPlugins }

abstract class HiveUtil {
  static Future<void> init() async {
    await Hive.initFlutter();

    final Box settings = await Hive.openBox(HiveName.settings.name);

    //Registry if Plugin is enabled or not
    await Hive.openBox(HiveName.plugin.name);

    // First time initializing app settings
    if (settings.isEmpty) {
      // Set to device language if device language is an available language, otherwise sets it to german
      settings.put(HiveKey.size.name, UIType.standard.name);
      settings.put(HiveKey.theme.name, ThemeMode.system.name);
    }

    // Registering generated Hive adapters
    Hive.registerAdapter(RoutineStatusAdapter());
    Hive.registerAdapter(DurationAdapter());
    Hive.registerAdapter(TimeOfDayAdapter());
    // Initializing needed Hive boxes
  }
}

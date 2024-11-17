import 'package:blue_tine_interpreted_components/interfaces/data/i_plugin_routine.dart';
import 'package:blue_tine_interpreted_components/interfaces/data/i_plugin_routine_data.dart';
import 'package:blue_tine_interpreted_components/interfaces/data/i_plugin_routine_step.dart';
import 'package:blue_tine_interpreted_components/interfaces/data/i_plugin_routine_step_data.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/controller/get_up_routine_controller.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/data/get_up_routine.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/data/get_up_routine_data.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/data/get_up_routine_step.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/data/get_up_routine_step_data.dart';
import 'package:blue_tine_interpreted_components/plugins/plugin.enum.dart';
import 'package:blue_tine_interpreted_components/plugins/plugin_manager.dart';
import 'package:blue_tine_interpreted_components/utils/hive_util.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

abstract class GetUp {
  static const PluginEnum plugin = PluginEnum.getUp;

  static Future<void> register() async {
    Hive.registerAdapter(GetUpControllerAdapter());
    if (!Hive.isBoxOpen(HiveName.plugin.name)) {
      await Hive.openBox(HiveName.plugin.name);
    }

    if (!PluginManager.pluginBox.containsKey(PluginEnum.getUp.name)) {
      await PluginManager.pluginBox.put(PluginEnum.getUp.name, GetUpController(PluginEnum.getUp));
    }
  }

  static Future<void> install() async {
    await _initHive();

    GetUpController controller = PluginManager.controller(plugin) as GetUpController;
    controller.isInstalled = true;

    await controller.save();
    // await PluginManager.pluginBox.put(PluginEnum.getUp.name, GetUpController(PluginEnum.getUp));
  }

  static Future<void> uninstall() async {
    await _deleteHive();

    GetUpController controller = PluginManager.controller(plugin) as GetUpController;
    controller.isInstalled = false;

    await controller.save();

    // await  PluginManager.pluginBox.put(plugin.name, null);
  }

  static Future<void> _initHive() async {
    Hive
      ..registerAdapter(GetUpRoutineAdapter(), override: true)
      ..registerAdapter(GetUpRoutineStepAdapter(), override: true)
      ..registerAdapter(GetUpRoutineDataAdapter(), override: true)
      ..registerAdapter(GetUpRoutineStepDataAdapter(), override: true);

    await Hive.openBox<IPluginRoutine>(HiveName.routine.plugin(plugin));
    await Hive.openBox<IPluginRoutineStep>(HiveName.step.plugin(plugin));

    await Hive.openBox<IPluginRoutineData>(HiveName.routineData.plugin(plugin));
    await Hive.openBox<IPluginRoutineStepData>(HiveName.stepData.plugin(plugin));

    await _setTestData();
  }

  static Future<void> _deleteHive() async {
    Hive.deleteBoxFromDisk(HiveName.routine.plugin(plugin));
    Hive.deleteBoxFromDisk(HiveName.step.plugin(plugin));

    Hive.deleteBoxFromDisk(HiveName.routineData.plugin(plugin));
    Hive.deleteBoxFromDisk(HiveName.stepData.plugin(plugin));
  }

  static Future<void> _setTestData() async {
    final Box<IPluginRoutineData> box = Hive.box<IPluginRoutineData>(HiveName.routineData.plugin(plugin));

    for (int i = 7; i <= 14; i++) {
      final GetUpRoutineData routineData = GetUpRoutineData(getUpRoutine)..test(day: i);

      await box.put(DateFormat.yMd().format(routineData.startTime), GetUpRoutineData(getUpRoutine)..test(day: i));
    }
  }

  static final GetUpRoutine getUpRoutine = GetUpRoutine(
    'Waking up',
    'Get out of bead and start your day',
    startTime: const TimeOfDay(hour: 6, minute: 0),
    steps: [
      GetUpRoutineStep(
        'Stretching',
        'To stretch',
        duration: const Duration(minutes: 5),
      ),
      GetUpRoutineStep(
        'Brushing Teeth',
        'To brush teeth',
        duration: const Duration(minutes: 2),
      ),
      GetUpRoutineStep(
        'Getting Dressed',
        'To get dressed',
        duration: const Duration(minutes: 3),
      )
    ],
  );
}

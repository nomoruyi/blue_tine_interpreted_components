import 'package:blue_tine_interpreted_components/interfaces/controller/plugin_controller.dart';
import 'package:blue_tine_interpreted_components/interfaces/data/i_plugin_routine_data.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/data/get_up_routine_data.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/get_up.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/ui/get_up_view.dart';
import 'package:blue_tine_interpreted_components/plugins/plugin.enum.dart';
import 'package:blue_tine_interpreted_components/utils/hive_util.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

part 'get_up_routine_controller.g.dart';

@HiveType(typeId: 20)
class GetUpController  extends PluginController {
  GetUpController(super.plugin);

  @override
  Box<IPluginRoutineData> get routineBox => Hive.box<IPluginRoutineData>(HiveName.routineData.plugin(plugin));

  @override
  List<IPluginRoutineData> get routines => (routineBox.values.toList()..sort((a, b) => b.startTime.compareTo(a.startTime)))  ;

  @override
  Future<void> install() async => await GetUp.install();

  @override
  Future<void> uninstall() async => await GetUp.uninstall();

  @override
  Future<Widget> loadPluginView() async {
    if (isInstalled) return const GetUpView();

    throw Exception('Plugin has to be enabled');
  }

  @override
  Future<void> saveRoutine(IPluginRoutineData routineData) async =>
      await routineBox.put(DateFormat.yMd().format(routineData.startTime), routineData as GetUpRoutineData);

  @override
  int getCurrentStreak() {
    if (routineBox.isEmpty) return 0;

    List<DateTime> startTimes = _getSortedDates();

    int currentStreak = 1;

    for (int i = startTimes.length - 1; i > 0; i--) {
      if (startTimes[i].difference(startTimes[i - 1]).inDays == 1) {
        currentStreak++;
      } else if (startTimes[i].difference(startTimes[i - 1]).inDays > 1) {
        break;
      }
    }

    return currentStreak;
  }

  @override
  int getMaxStreak() {
    if (routineBox.isEmpty) return 0;

    List<DateTime> startTimes = _getSortedDates();

    int maxStreak = 1;
    int currentStreak = 1;

    for (int i = 1; i < startTimes.length; i++) {
      if (startTimes[i].difference(startTimes[i - 1]).inDays == 1) {
        currentStreak++;
      } else if (startTimes[i].difference(startTimes[i - 1]).inDays > 1) {
        currentStreak = 1;
      }

      if (currentStreak > maxStreak) {
        maxStreak = currentStreak;
      }
    }

    return maxStreak;
  }

  @override
  int getTotalExecutions() => routineBox.values.length;

  @override
  double getAvgRating() => routineBox.values.map((r) => r.rating).reduce((a, b) => a + b) / getTotalExecutions();

  List<DateTime> _getSortedDates() => routineBox.values.map((data) => data.startTime).toList()..sort();
}

import 'package:blue_tine_interpreted_components/interfaces/data/i_plugin_routine_step.dart';
import 'package:blue_tine_interpreted_components/utils/format_util.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IPluginRoutine with HiveObjectMixin {
  //region VARIABLES
  @HiveField(0, defaultValue: 'Routine Name')
  final String name;

  @HiveField(1, defaultValue: 'Routine Description')
  final String? description;

  @HiveField(2, defaultValue: TimeOfDay(hour: 6, minute: 00))
  final TimeOfDay startTime;

  TimeOfDay get endTime => startTime.add(duration);

  Duration get duration => _calcDuration();

  @HiveField(3, defaultValue: [])
  final List<int> weekDays = [];

  @HiveField(4, defaultValue: false)
  final bool reminder;

  @HiveField(5, defaultValue: [])
  final List<IPluginRoutineStep> steps;

  //endregion

  IPluginRoutine(this.name, this.description, {required this.steps, required this.startTime, this.reminder = true});

  //region METHODS
  Duration _calcDuration() => steps.fold(Duration.zero, (duration, step) => duration + step.duration);
//endregion

}


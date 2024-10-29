
import 'dart:math';

import 'package:blue_tine_interpreted_components/interfaces/data/enums/routine_status.dart';
import 'package:blue_tine_interpreted_components/interfaces/data/i_plugin_routine.dart';
import 'package:blue_tine_interpreted_components/interfaces/data/i_plugin_routine_step_data.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IPluginRoutineData<Plugin> with EquatableMixin, HiveObjectMixin {
  //region VARIABLES
  String get name => routine.name;

  @HiveField(0)
  final IPluginRoutine routine;

  @HiveField(1, defaultValue: RoutineStatus.open)
  RoutineStatus status;

  @HiveField(2)
  late final DateTime startTime;

  @HiveField(3)
  late final DateTime endTime;

  Duration get duration => _calcDuration();

  @HiveField(4, defaultValue: 0)
  double rating;

  @HiveField(5)
  String? comment;

  @HiveField(6)
  final List<IPluginRoutineStepData> stepsData = [];

  //endregion

  IPluginRoutineData(this.routine, {this.status = RoutineStatus.open, this.rating = 0, this.comment}) : assert(rating >= 0 && rating <= 5);

  //TODO: Implement checks that these function throw errors when trying to start/stop/abort when the status is wrong
  void start() {
    startTime = DateTime.now();
    status = RoutineStatus.active;
  }

  void end() {
    endTime = DateTime.now();
    status = RoutineStatus.finished;
  }

  void abort() {
    endTime = DateTime.now();
    status = RoutineStatus.aborted;
  }

  void test({int year = 2024, int month = 08, int day = 01}) {
    final Random random =  Random();

    final testDate = DateTime.now().subtract(Duration(days: day));

    startTime = testDate;
    endTime = testDate.add(Duration(minutes: random.nextInt(6)));
    status = RoutineStatus.finished;
    
    rating = random.nextInt(6).toDouble();
  }

  //region METHODS
  Duration _calcDuration() => stepsData.fold(Duration.zero, (duration, step) => duration + step.duration);
//endregion
}

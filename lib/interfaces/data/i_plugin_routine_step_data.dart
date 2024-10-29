import 'package:blue_tine_interpreted_components/interfaces/data/enums/routine_status.dart';
import 'package:blue_tine_interpreted_components/interfaces/data/i_plugin_routine_step.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IPluginRoutineStepData with EquatableMixin, HiveObjectMixin {
  //region VARIABLES
  String get name => step.name;

  @HiveField(0)
  final IPluginRoutineStep step;

  @HiveField(1, defaultValue: RoutineStatus.open)
  RoutineStatus status;

  @HiveField(2)
  late final DateTime startTime;

  @HiveField(3)
  late final DateTime endTime;

  @HiveField(4)
  late final Duration duration;

  Duration? get discrepancy => duration - step.duration;

  @HiveField(5, defaultValue: false)
  bool skipped;

  //endregion

  IPluginRoutineStepData(this.step, {this.status = RoutineStatus.open, this.skipped = false});

  //region METHODS
  void start() {
    startTime = DateTime.now();
    status = RoutineStatus.active;
  }

  void end({required Duration duration}) {
    this.duration = duration;
    endTime = DateTime.now();
    status = RoutineStatus.finished;
  }

  void abort({Duration? duration}) {
    if (duration != null) this.duration = duration;
    endTime = DateTime.now();
    status = RoutineStatus.aborted;
  }

//endregion
}

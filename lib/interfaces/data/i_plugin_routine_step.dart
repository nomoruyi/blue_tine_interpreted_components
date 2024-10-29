import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IPluginRoutineStep with EquatableMixin, HiveObjectMixin {
  //region VARIABLES
  @HiveField(0, defaultValue: 'Step Name')
  final String name;

  @HiveField(1, defaultValue: 'Step Description')
  final String? description;

  @HiveField(2, defaultValue: Duration(minutes: 5))
  final Duration duration;

  @HiveField(3, defaultValue: true)
  final bool isActive;

  @HiveField(4, defaultValue: false)
  final bool autoNext;
  //endregion

  IPluginRoutineStep(this.name, this.description, {required this.duration, this.isActive = true, this.autoNext = false});

/*  IPluginRoutineStepData toData({String? newDescription, required Duration actualDuration })
  {
    return IPluginRoutineStepData(name, actualDuration, description: description, duration: duration)

  } */

  //region METHODS

  @override
  List<Object?> get props => [name, description];
  //endregion
}

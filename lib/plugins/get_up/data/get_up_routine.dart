import 'package:blue_tine_interpreted_components/interfaces/data/i_plugin_routine.dart';
import 'package:blue_tine_interpreted_components/interfaces/data/i_plugin_routine_step.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'get_up_routine.g.dart';

@HiveType(typeId: 21)
class GetUpRoutine extends IPluginRoutine {
  GetUpRoutine(super.name, super.description, {required super.steps, required super.startTime, super.reminder = true});
}

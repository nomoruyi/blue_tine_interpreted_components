import 'package:blue_tine_interpreted_components/interfaces/data/enums/routine_status.dart';
import 'package:blue_tine_interpreted_components/interfaces/data/i_plugin_routine_step.dart';
import 'package:blue_tine_interpreted_components/interfaces/data/i_plugin_routine_step_data.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'get_up_routine_step_data.g.dart';

@HiveType(typeId: 25)
class GetUpRoutineStepData extends IPluginRoutineStepData{
  GetUpRoutineStepData(super.step, {super.skipped });
}

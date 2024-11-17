import 'package:blue_tine_interpreted_components/interfaces/data/enums/routine_status.dart';
import 'package:blue_tine_interpreted_components/interfaces/data/i_plugin_routine.dart';
import 'package:blue_tine_interpreted_components/interfaces/data/i_plugin_routine_data.dart';
import 'package:hive_flutter/adapters.dart';

part 'get_up_routine_data.g.dart';

@HiveType(typeId: 23)
class GetUpRoutineData extends IPluginRoutineData{
  GetUpRoutineData( super.routine, { super.status = RoutineStatus.open, super.rating = 0});
}

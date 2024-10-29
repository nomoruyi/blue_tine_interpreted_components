import 'package:blue_tine_interpreted_components/interfaces/data/i_plugin_routine_data.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class IPluginRoutineCalendarEntry extends Appointment {

  final IPluginRoutineData routineData;

  // IPluginRoutineCalendarEntry(this.stepData, {required super.startTime, required super.endTime});

  IPluginRoutineCalendarEntry.fromRoutineData(this.routineData) : super(
    subject: routineData.name,
    startTime: routineData.startTime,
    endTime: routineData.startTime,
  );
}

const String getUpAnalysisView = '''
import 'package:blue_tine_interpreted_components/app/cubits/routine/routine_cubit.dart';
import 'package:blue_tine_interpreted_components/app/data/calendar/i_plugin_routine_calendar_entry.dart';
import 'package:blue_tine_interpreted_components/app/ui/widgets/blue_analysis.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/get_up_main.dart';
import 'package:blue_tine_interpreted_components/plugins/plugin.enum.dart';
import 'package:blue_tine_interpreted_components/plugins/plugin_manager.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class GetUpAnalysisView extends StatefulWidget {
  const GetUpAnalysisView(this.plugin, {super.key});

  final PluginEnum plugin;

  @override
  GetUpAnalysisViewState createState() => GetUpAnalysisViewState();
}

class GetUpAnalysisViewState extends State<GetUpAnalysisView> {
  late final PluginController _routineCubit = PluginManager.plugins[GetUpP]!;

  final List<Appointment> _calendarAppointments = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _calendarAppointments.addAll(_routineCubit.routines.map((r) => IPluginRoutineCalendarEntry.fromRoutineData(r)));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Headline(_routineCubit),
            Calendar(_routineCubit, calendarEntries: _calendarAppointments),
            ToDo(_routineCubit),
            LastExecs(_routineCubit),
          ],
        ),
      )

      child: ListView.separated(
        itemCount: _widgets.length,
        itemBuilder: (context, index) {
          return _widgets[index];
        },
        separatorBuilder: (context, index) {
          return const Divider(height: 16.0, thickness: 0, color: Colors.transparent);
        },
      )

      ,
    );
  }
}

''';
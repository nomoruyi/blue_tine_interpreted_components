import 'package:blue_tine_interpreted_components/interfaces/controller/plugin_controller.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/data/get_up_routine_data.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/get_up.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/data/get_up_data.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/data/get_up_routine.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/ui/get_up_routine_active.dart';
import 'package:blue_tine_interpreted_components/plugins/plugin_manager.dart';
import 'package:blue_tine_interpreted_components/plugins/plugin.enum.dart';
import 'package:blue_tine_interpreted_components/utils/format_util.dart';
import 'package:flutter/material.dart';


class GetUpView extends StatefulWidget {
  const GetUpView( {super.key});

  @override
  State<GetUpView> createState() => _PluginGetUpState();
}

class _PluginGetUpState extends State<GetUpView> {
  final PluginController routineCubit = PluginManager.controller(PluginEnum.getUp);
  final GetUpData data = GetUpData(PluginEnum.getUp, description: 'A routine for waking up');

  final GetUpRoutine routine = GetUp.getUpRoutine;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text(data.name),
          subtitle: Text(data.description),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () => print('Push "Step"'),
                  title: Text(routine.steps[index].name),
                  leading: const Icon(Icons.add),
                  trailing: Text(routine.steps[index].duration.formatDuration()),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(height: 8.0),
            itemCount: routine.steps.length),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: IconButton.filled(
        onPressed: () => _startRoutine(context),
        icon: const Icon(Icons.play_arrow_rounded, size: 40.0),
      ),
    );
  }

  Future<void> _startRoutine(BuildContext context) async {
    GetUpRoutineData routineData = GetUpRoutineData(routine)
      ..start();

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => GetUpRoutineActive(routineData, stepIndex: 0)));
  }
}
import 'package:blue_tine_interpreted_components/interfaces/data/i_plugin_routine_step_data.dart';
import 'package:blue_tine_interpreted_components/utils/format_util.dart';
import 'package:flutter/material.dart';

class BlueStepTile extends StatelessWidget {
  const BlueStepTile({super.key, required this.stepData});

  final IPluginRoutineStepData stepData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.circle_outlined) ,
      title: Text('${stepData.step.name} - ${stepData.duration.formatDuration()}'),
      trailing: stepData.discrepancy != null ?  Text(stepData.discrepancy!.formatDuration()): null,
    );
  }
}

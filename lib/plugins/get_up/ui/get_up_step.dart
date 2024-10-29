import 'package:blue_tine_interpreted_components/plugins/get_up/data/get_up_routine_step.dart';
import 'package:blue_tine_interpreted_components/interfaces/ui/i_plugin_widget.dart';
import 'package:flutter/material.dart';

class GetUpStep extends IPluginStatelessWidget {
  final GetUpRoutineStep data;

  const GetUpStep(super.plugin, this.data, {super.key, required});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(child: Text(data.name))
          ],
        ),
      ),
    );
  }
}

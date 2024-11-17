import 'package:blue_tine_interpreted_components/interfaces/controller/plugin_controller.dart';
import 'package:blue_tine_interpreted_components/app/ui/widgets/blue_analysis.dart';
import 'package:blue_tine_interpreted_components/plugins/plugin.enum.dart';
import 'package:blue_tine_interpreted_components/plugins/plugin_manager.dart';
import 'package:flutter/material.dart';

class PluginAnalyticsView extends StatefulWidget {
  const PluginAnalyticsView(this.plugin, {super.key});

  final PluginEnum plugin;

  @override
  PluginAnalyticsViewState createState() => PluginAnalyticsViewState();
}

class PluginAnalyticsViewState<T> extends State<PluginAnalyticsView> {
//TODO: Use Plugin Manager
  late   final PluginController _routineCubit = PluginManager.controller(widget.plugin);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Headline(_routineCubit),
            LastExecs(_routineCubit),
          ],
        ),
      ),
    );
  }
}

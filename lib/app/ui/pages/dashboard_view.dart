import 'package:blue_tine_interpreted_components/interfaces/controller/plugin_controller.dart';
import 'package:blue_tine_interpreted_components/app/ui/widgets/plugin_dashboard_card.dart';
import 'package:blue_tine_interpreted_components/plugins/plugin_manager.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late final List<PluginController> pluginControllers = PluginManager.installedPlugins;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w900)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: ListView.separated(
          itemCount: pluginControllers.length,
          itemBuilder: (context, index) {
            return FutureBuilder(future: pluginControllers[index].loadPluginView(), builder: (context, snapshot){

              if(!snapshot.hasData) return const Text('LOADING');
              if(snapshot.hasError) return const Text('ERROR');

              return PluginDashboardCard(pluginControllers[index], snapshot.requireData);
            });
          },
          separatorBuilder: (context, index) {
            return const Divider(height: 4.0, thickness: 0, color: Colors.transparent);
          },
        ),
      ),
    );
  }
}

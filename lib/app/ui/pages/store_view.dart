import 'package:blue_tine_interpreted_components/interfaces/controller/plugin_controller.dart';
import 'package:blue_tine_interpreted_components/app/ui/widgets/plugin_store_card.dart';
import 'package:blue_tine_interpreted_components/plugins/plugin_manager.dart';
import 'package:flutter/material.dart';

class StoreView extends StatefulWidget {
  const StoreView({super.key});

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  final List<PluginController> pluginLoadingFunctions = PluginManager.registeredPlugins;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store', style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w900)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: ListView.separated(
          itemCount: pluginLoadingFunctions.length,
          itemBuilder: (context, index) {
            return PluginStoreCard( pluginLoadingFunctions[index]);
          },
          separatorBuilder: (context, index) {
            return const Divider(height: 4.0, thickness: 0, color: Colors.transparent);
          },
        ),
      ),
    );
  }
}

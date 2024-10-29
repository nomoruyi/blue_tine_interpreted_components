import 'package:blue_tine_interpreted_components/app/cubits/routine/routine_cubit.dart';
import 'package:blue_tine_interpreted_components/app/ui/widgets/plugin_store_card.dart';
import 'package:blue_tine_interpreted_components/plugins/plugin_manager.dart';
import 'package:flutter/material.dart';

class StoreView extends StatefulWidget {
  const StoreView({super.key});

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  final List<PluginController> pluginLoadingFunctions = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for(PluginController controller in PluginManager.plugins.values) {
      pluginLoadingFunctions.add(controller);
    }
  }
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
            return PluginStoreCard(PluginManager.plugins.values.toList()[index].plugin, pluginLoadingFunctions[index]);
          },
          separatorBuilder: (context, index) {
            return const Divider(height: 4.0, thickness: 0, color: Colors.transparent);
          },
        ),
      ),
    );
  }
}

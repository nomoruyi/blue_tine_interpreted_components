import 'package:blue_tine_interpreted_components/interfaces/ui/i_plugin_widget.dart';
import 'package:flutter/material.dart';

class PluginDashboardCard extends IPluginStatelessWidget {
  const PluginDashboardCard(super.plugin, this.widget, {super.key });

  final Widget widget;

  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(
        title: Text(plugin.name),
        subtitle: const Text('plugin.description'),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget)),
      ),
    );
  }
}

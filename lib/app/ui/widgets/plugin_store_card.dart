import 'package:blue_tine_interpreted_components/app/cubits/routine/routine_cubit.dart';
import 'package:blue_tine_interpreted_components/interfaces/ui/i_plugin_stateful_widget.dart';
import 'package:flutter/material.dart';

class PluginStoreCard extends IPluginStatefulWidget {
  const PluginStoreCard(super.plugin, this.pluginController, {super.key});

  final PluginController pluginController;

  @override
  State<PluginStoreCard> createState() => _PluginStoreCardState();
}

class _PluginStoreCardState extends State<PluginStoreCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.plugin.name),
        subtitle: const Text('plugin.description'),
        onTap: () => _openDialog(context),
      ),
    );
  }

  _openDialog(BuildContext context) {
    enable(){
      setState((){
        widget.pluginController.enable();
      });
      Navigator.of(context).pop();
    }

    disable(){
      setState((){
        widget.pluginController.disable();
      });
      Navigator.of(context).pop();
    }

    showDialog(
        context: context,
        builder: (ctx) {
          return SimpleDialog(
            title: const Text('Was möchten Sie mit dem Plugin tun?'),
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () => enable(), child: const Text('Installieren')),
                  ElevatedButton(onPressed: () => disable(), child: const Text('Deinstallieren')),
                ],
              )
            ],
          );
        });
  }
}

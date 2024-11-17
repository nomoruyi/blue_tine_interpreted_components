import 'package:blue_tine_interpreted_components/interfaces/controller/plugin_controller.dart';
import 'package:flutter/material.dart';

class PluginDashboardCard extends StatefulWidget {
  const PluginDashboardCard(this.pluginController, this.pluginView, {super.key});

  final PluginController pluginController;
  final Widget pluginView;

  @override
  State<PluginDashboardCard> createState() => _PluginStoreCardState();
}

class _PluginStoreCardState extends State<PluginDashboardCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.pluginController.plugin.name),
        subtitle: const Text('plugin.description'),
        onTap: () => _openDialog(context),
      ),
    );
  }

  _openDialog(BuildContext context) {
    start()  {
      Navigator.of(context).pop();

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget.pluginView));
    }

    uninstall() async {
      await widget.pluginController.uninstall();


      if (context.mounted) {
        Navigator.of(context).pop();
        Navigator.of(context).popAndPushNamed('/');
      }
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
                  ElevatedButton(
                    onPressed: () => start(),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade500),
                    child: const Text('Starten'),
                  ),
                  ElevatedButton(
                      onPressed: () async => await uninstall(),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade500),
                      child: const Text('Deinstallieren')),
                ],
              )
            ],
          );
        });
  }
}

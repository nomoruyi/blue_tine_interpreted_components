import 'package:blue_tine_interpreted_components/interfaces/controller/plugin_controller.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/get_up.dart';
import 'package:blue_tine_interpreted_components/plugins/plugin.enum.dart';
import 'package:blue_tine_interpreted_components/utils/hive_util.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PluginManager {

  static Box get pluginBox => Hive.box(HiveName.plugin.name);

  static PluginController controller(PluginEnum plugin) => pluginBox.get(plugin.name)!;

  static List<PluginController> get registeredPlugins => pluginBox.values.isEmpty ? <PluginController>[] : pluginBox.values.whereType<PluginController>().toList();

  static List<PluginController> get installedPlugins => pluginBox.values.isEmpty ? <PluginController>[] : pluginBox.values.whereType<PluginController>().where((con)=> con.isInstalled).toList();

  /// Hier werden müssen sämtliche Plugins, die es für die App gibt, registriert werden
  static Future<void> init() async {
    await GetUp.register();
  }
}


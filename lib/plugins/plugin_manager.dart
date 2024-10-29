import 'package:blue_tine_interpreted_components/app/cubits/routine/routine_cubit.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/get_up_main.dart';
import 'package:blue_tine_interpreted_components/utils/hive_util.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PluginManager {
  static Map<Type, PluginController> plugins = {};

  static Box get pluginBox => Hive.box(HiveName.plugin.name);


  static Future<void> init() async {
    // plugins[Plugin.dummy] = initDummy;
    GetUpP.register();

  }
}

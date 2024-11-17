import 'package:blue_tine_interpreted_components/plugins/plugin.enum.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IPluginData with HiveObjectMixin {
  @HiveField(0)
  final PluginEnum plugin;

  @HiveField(1, defaultValue: 'Plugin Name')
  final String name;

  @HiveField(2, defaultValue: 'Plugin Description')
  final String description;

  IPluginData(this.plugin, {required this.description}) : name = plugin.name;
}

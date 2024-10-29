import 'package:blue_tine_interpreted_components/plugins/plugin.enum.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';


abstract class IPluginData with EquatableMixin, HiveObjectMixin{
  @HiveField(0)
  final PluginEnum plugin;

  @HiveField(1, defaultValue: 'Plugin Name')
  final String name;

  @HiveField(2, defaultValue: 'Plugin Description')
  final String description;

  //TODO: Hier einen Datentyp für die Nutzungszeit
  final dynamic userData = null;

  IPluginData(this.plugin, {required this.description}) : name = plugin.name ;


  @override
  List<Object?> get props => [name, description];
}
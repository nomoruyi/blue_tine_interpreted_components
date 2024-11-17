import 'package:hive_flutter/hive_flutter.dart';

part 'plugin.enum.g.dart';

@HiveType(typeId: 000)
enum PluginEnum{
     @HiveField(0)
     getUp
}
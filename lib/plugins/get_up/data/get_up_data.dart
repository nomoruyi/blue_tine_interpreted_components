import 'package:blue_tine_interpreted_components/interfaces/data/i_plugin_data.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:blue_tine_interpreted_components/plugins/plugin.enum.dart';

part 'get_up_data.g.dart';

@HiveType(typeId: 21)
class GetUpData extends IPluginData {
  GetUpData(super.plugin, { required super.description});
}

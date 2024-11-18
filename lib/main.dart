import 'package:blue_tine_interpreted_components/app/app.dart';
import 'package:blue_tine_interpreted_components/plugins/plugin_manager.dart';
import 'package:blue_tine_interpreted_components/utils/hive_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  initializeDateFormatting();

  await HiveUtil.init();

  await PluginManager.init();

  runApp(const BlueTineApp());
}
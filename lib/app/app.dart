import 'package:blue_tine_interpreted_components/app/controller/settings/settings_cubit.dart';
import 'package:blue_tine_interpreted_components/app/ui/base_view.dart';
import 'package:blue_tine_interpreted_components/utils/settings_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlueTineApp extends StatefulWidget {
  const BlueTineApp({super.key});

  @override
  State<BlueTineApp> createState() => _BlueTineAppState();
}

class _BlueTineAppState extends State<BlueTineApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final SettingsCubit settings = BlocProvider.of<SettingsCubit>(context);

          // WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = () => setState(() {});

          UISize.selectedUIType = settings.size;

          return Builder(builder: (context) {
            return MaterialApp(
              title: 'BLUEtine',
              darkTheme: darkTheme,
              theme: lightTheme,
              themeMode: settings.theme,
              initialRoute: '/',
              home: const BaseView(),
            );
          });
        },
      ),
    );
  }
}

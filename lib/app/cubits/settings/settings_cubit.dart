import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:blue_tine_interpreted_components/utils/_utils.export.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState>  {
  SettingsCubit() : super(SettingsInitial());

  static final Box settings = Hive.box(HiveName.settings.name);

  //region LANGUAGE
  String get language => settings.get(HiveKey.language.name);

  set language(String newLanguage) {
    // authLog.i('SETTINGS - language($newLanguage)');

    settings.put(HiveKey.language.name, newLanguage);

    emit(LanguageChanged(newLanguage));
  }

  static String? getLanguageFlag(String localeCode) {
    switch (localeCode) {
      case 'de':
        return '🇩🇪';
      case 'en':
        return '🇬🇧';
      case 'fr':
        return '🇫🇷';
      default:
        return null;
    }
  }

  //endregion

  //region SIZE
  static final List<String> allSupportedSizes = UIType.values.map((size) => size.name).toList();

  String get size => settings.get(HiveKey.size.name);

  set size(String newSize) {
    // authLog.i('SETTINGS - size($newSize)');

    settings.put(HiveKey.size.name, newSize);

    emit(SizeChanged(newSize));
  }

  //endregion

  //region THEME
  ThemeMode get theme => ThemeMode.values.byName(settings.get(HiveKey.theme.name));

  set theme(ThemeMode newTheme) {
    // authLog.i('SETTINGS - theme($newTheme)');

    settings.put(HiveKey.theme.name, newTheme.name);

    emit(ThemeChanged(newTheme.name, useSystemTheme: false));
  }

  ThemeData getThemeData(Brightness brightness) {
    switch (theme) {
      case ThemeMode.system:
        return brightness == Brightness.light ? lightTheme : darkTheme;
      case ThemeMode.light:
        return lightTheme;
      case ThemeMode.dark:
        return darkTheme;
    }
  }

  SystemUiOverlayStyle getUiOverlyStyle() {
    switch (theme) {
      case ThemeMode.system:
        return SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.light ? lightSystemOverlayStyle : darkSystemOverlayStyle;
      case ThemeMode.light:
        return lightSystemOverlayStyle;
      case ThemeMode.dark:
        return darkSystemOverlayStyle;
    }
  }

  String getAppIconPath() {
    switch (theme) {
      case ThemeMode.system:
        return SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.light ? assetAppIconLight : assetAppIconDark;
      case ThemeMode.light:
        return assetAppIconLight;
      case ThemeMode.dark:
        return assetAppIconDark;
    }
  }

  String getSplashScreenPath() {
    switch (theme) {
      case ThemeMode.system:
        return SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.light ? assetSplashScreenLight : assetSplashScreenDark;
      case ThemeMode.light:
        return assetSplashScreenLight;
      case ThemeMode.dark:
        return assetSplashScreenDark;
    }
  }

//endregion

  void reset() {
    // authLog.i('SETTINGS - reset()');

    settings.put(HiveKey.language.name, LanguageCode.de.name);
    settings.put(HiveKey.size.name, UIType.standard.name);
    settings.put(HiveKey.theme.name, ThemeMode.system.name);

    emit(SettingsResetted());
  }

  @override
  void onChange(Change<SettingsState> change) {
    // authLog.t('${change.currentState} --> ${change.nextState}');

    super.onChange(change);
  }
}

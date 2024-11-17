part of 'settings_cubit.dart';

abstract class SettingsState {
  const SettingsState();
}

class SettingsInitial extends SettingsState {
}

class LanguageChanged extends SettingsState {
  final String newLocale;

  const LanguageChanged(this.newLocale);
}

class SizeChanged extends SettingsState {
  final String newSize;

  const SizeChanged(this.newSize);
}

class ThemeChanged extends SettingsState {
  final String newTheme;
  final bool useSystemTheme;

  const ThemeChanged(this.newTheme, {required this.useSystemTheme});
}

class SettingsResetted extends SettingsState {
}

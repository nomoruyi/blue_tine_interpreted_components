part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
}

class SettingsInitial extends SettingsState {
  @override
  List<Object> get props => [];
}

class LanguageChanged extends SettingsState {
  final String newLocale;

  const LanguageChanged(this.newLocale);

  @override
  List<Object> get props => [newLocale];
}

class SizeChanged extends SettingsState {
  final String newSize;

  const SizeChanged(this.newSize);

  @override
  List<Object> get props => [newSize];
}

class ThemeChanged extends SettingsState {
  final String newTheme;
  final bool useSystemTheme;

  const ThemeChanged(this.newTheme, {required this.useSystemTheme});

  @override
  List<Object> get props => [newTheme, 'Use System Settings: $useSystemTheme'];
}

class SettingsResetted extends SettingsState {
  @override
  List<Object> get props => [];
}

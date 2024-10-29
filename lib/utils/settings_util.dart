import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum UIType { compact, standard, comfortable }

enum LanguageCode { de, en, fr }

//region THEME
// This theme was made for FlexColorScheme version 6.1.1. Make sure
// you use same or higher version, but still same major version. If
// you use a lower version, some properties may not be supported. In
// that case you can also remove them after copying the theme to your app.
final ThemeData lightTheme = FlexThemeData.light(
    scheme: FlexScheme.blumineBlue,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 9,
    appBarElevation: 4.0,
    // applyElevationOverlayColor: false,
    subThemesData: const FlexSubThemesData(
      buttonMinSize: Size(80.0, 44.0),
      buttonPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      textButtonRadius: 12.0,
      elevatedButtonRadius: 12.0,
      outlinedButtonRadius: 12.0,
      toggleButtonsRadius: 12.0,
      inputDecoratorRadius: 12.0,
      blendOnLevel: 10,
      blendOnColors: false,
      cardRadius: 24.0,
      cardElevation: 8.0,
      // toggleButtonsSchemeColor: SchemeColor.background,
    ),
    keyColors: const FlexKeyColors(
      useSecondary: true,
      useTertiary: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    );

final ThemeData darkTheme = FlexThemeData.dark(
    scheme: FlexScheme.blumineBlue,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 15,
    appBarElevation: 4.0,
    applyElevationOverlayColor: false,
    subThemesData: const FlexSubThemesData(
      buttonMinSize: Size(80.0, 40.0),
      buttonPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      textButtonRadius: 12.0,
      elevatedButtonRadius: 12.0,
      outlinedButtonRadius: 12.0,
      toggleButtonsRadius: 12.0,
      inputDecoratorRadius: 12.0,
      blendOnLevel: 20,
      cardRadius: 24.0,
      cardElevation: 8.0,

      // toggleButtonsSchemeColor: SchemeColor.background,
    ),
    keyColors: const FlexKeyColors(
      useSecondary: true,
      useTertiary: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    );

/* COLORS
* primary: 0xFF9CD67D
* primary_container: 0xFF205107
* brown_light_mode: 0xFF522A0B
* brown_dark_mode: 0xFFA47551
* secondary: 0xFFBDCBB0
* secondary_container: 0xFF3E4A36
* tertiary: 0xFFA0CFD0
* tertiary_container: 0xFF1E4E4F
* error: 0xFFCF6679
* error_container: 0xFFB1384E
*/
const String assetAppIconLight = 'assets/icons/bio_courier_app_icon.png';
const String assetAppIconDark = 'assets/icons/bio_courier_app_icon_dark.png';
const String assetSplashScreenLight = 'assets/splash_screens/bio_courier_splash_screen.png';
const String assetSplashScreenDark = 'assets/splash_screens/bio_courier_splash_screen_dark.png';

const Color oekoPrimaryLight = Color(0xFF386A1F);
const Color oekoPrimaryDark = Color(0xFF9CD67E);

const Color oekoWhite = Color(0xffffffff);
const Color oekoBlack = Color(0xff0c0f0c);

const Color oekoBaseLight = Color(0xffeaefd9);
const Color oekoBaseDark = Color(0xff181e18);

const lightSystemOverlayStyle = SystemUiOverlayStyle(
  statusBarColor: oekoBaseLight,
  statusBarBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.dark,
  systemStatusBarContrastEnforced: true,
  systemNavigationBarColor: oekoBaseLight,
  systemNavigationBarContrastEnforced: true,
  systemNavigationBarIconBrightness: Brightness.dark,
  systemNavigationBarDividerColor: oekoBaseLight,
);

const darkSystemOverlayStyle = SystemUiOverlayStyle(
  statusBarColor: oekoBaseDark,
  statusBarBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.light,
  systemStatusBarContrastEnforced: true,
  systemNavigationBarColor: oekoBaseDark,
  systemNavigationBarContrastEnforced: true,
  systemNavigationBarIconBrightness: Brightness.light,
  systemNavigationBarDividerColor: oekoBaseDark,
);
//endregion

/// Class to get standardized text sizes
/// There may be a way to clean this up and make it more readable, but for now, this should suffice
abstract class UISize {
  static const double _oekoMaxSize = 32.0;
  static const double _oekoExtraLarge = 24.0;
  static const double _oekoLargeText = 20.0;
  static const double _oekoMediumText = 16.0;
  static const double _oekoSmallText = 12.0;
  static const double _oekoTinyText = 10.0;
  static const double _oekoMinSize = 8.0;

  static const String _tiny = 'tiny';
  static const String _small = 'small';
  static const String _medium = 'normal';
  static const String _large = 'large';
  static const String _extraLarge = 'extraLarge';

  static final Map<String, Map<String, double>> sizes = {
    UIType.compact.name: {
      _tiny: _oekoMinSize,
      _small: _oekoTinyText,
      _medium: _oekoSmallText,
      _large: _oekoMediumText,
      _extraLarge: _oekoLargeText,
    },
    UIType.standard.name: {
      _tiny: _oekoTinyText,
      _small: _oekoSmallText,
      _medium: _oekoMediumText,
      _large: _oekoLargeText,
      _extraLarge: _oekoExtraLarge,
    },
    UIType.comfortable.name: {
      _tiny: _oekoSmallText,
      _small: _oekoMediumText,
      _medium: _oekoLargeText,
      _large: _oekoExtraLarge,
      _extraLarge: _oekoMaxSize,
    },
  };

  static String selectedUIType = UIType.standard.name;

  static double get tiny => sizes[selectedUIType]![_tiny]!;

  static double get small => sizes[selectedUIType]![_small]!;

  static double get medium => sizes[selectedUIType]![_medium]!;

  static double get large => sizes[selectedUIType]![_large]!;

  static double get extraLarge => sizes[selectedUIType]![_extraLarge]!;

  static double get iconSmall => small * 2;

  static double get iconMedium => medium * 2;

  static double get iconLarge => large * 2;
}

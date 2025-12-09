import 'package:sis_flutter/values/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

final ThemeData appThemeLight = _buildThemeLight();
final ThemeData appThemeLightDarkAppBar = _buildThemeLight().copyWith(
  appBarTheme: _buildAppBarThemeDark(),
);

ThemeData _buildThemeLight() {
  final ThemeData base = ThemeData.light();

  const Color primary = primaryColor;
  const Color secondary = accentColor;

  return base.copyWith(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: MaterialColor(primary.value, <int, Color>{
        50: primary.withOpacity(0.1),
        100: primary.withOpacity(0.2),
        200: primary.withOpacity(0.3),
        300: primary.withOpacity(0.4),
        400: primary.withOpacity(0.5),
        500: primary.withOpacity(0.6),
        600: primary.withOpacity(0.7),
        700: primary.withOpacity(0.8),
        800: primary.withOpacity(0.9),
        900: primary.withOpacity(1.0),
      }),
      accentColor: secondary,
      brightness: Brightness.light,
    ).copyWith(
      secondary: secondary,
      primary: primary,
      surface: Colors.white,
    ),
    textTheme: buildTextTheme(base.textTheme),
    iconTheme: _buildActionIconTheme(),
    appBarTheme: _buildAppBarThemeLight(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: primaryColor,
    ),
  );
}

IconThemeData _buildActionIconTheme() {
  return const IconThemeData(color: actionIconColorLight, size: 24);
}

AppBarTheme _buildAppBarThemeLight() {
  return AppBarTheme(
    iconTheme: _buildActionIconTheme(),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    foregroundColor: Colors.white,
    elevation: 0,
  );
}

AppBarTheme _buildAppBarThemeDark() {
  return const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.light,
    backgroundColor: Color(0xFF333333),
    iconTheme: IconThemeData(color: Colors.white, size: 24),
    elevation: 0,
  );
}


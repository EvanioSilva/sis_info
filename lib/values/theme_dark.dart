import 'package:sis_flutter/values/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

final ThemeData appThemeDark = _buildThemeDark();

ThemeData _buildThemeDark() {
  final ThemeData base = ThemeData.dark();

  const Color primaryColorDark = primaryColor;
  const Color secondaryColorDark = accentColor;
  final Color scaffoldBackgroundColor = Colors.grey[800]!;

  return base.copyWith(
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: MaterialColor(primaryColorDark.value, <int, Color>{
        50: primaryColorDark.withOpacity(0.1),
        100: primaryColorDark.withOpacity(0.2),
        200: primaryColorDark.withOpacity(0.3),
        300: primaryColorDark.withOpacity(0.4),
        400: primaryColorDark.withOpacity(0.5),
        500: primaryColorDark.withOpacity(0.6),
        600: primaryColorDark.withOpacity(0.7),
        700: primaryColorDark.withOpacity(0.8),
        800: primaryColorDark.withOpacity(0.9),
        900: primaryColorDark.withOpacity(1.0),
      }),
      accentColor: secondaryColorDark,
      brightness: Brightness.dark,
    ).copyWith(
      secondary: secondaryColorDark,
      primary: primaryColorDark,
      surface: scaffoldBackgroundColor,
    ),
    textTheme: buildTextTheme(base.textTheme),
    iconTheme: _buildIconTheme(),
    appBarTheme: _buildAppBarTheme(scaffoldBackgroundColor),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

IconThemeData _buildIconTheme() {
  return const IconThemeData(color: ksecondaryColor, size: 24);
}

AppBarTheme _buildAppBarTheme(Color appBarColor) {
  return AppBarTheme(
    iconTheme: _buildIconTheme(),
    systemOverlayStyle: SystemUiOverlayStyle.light,
    backgroundColor: appBarColor,
    elevation: 0,
  );
}


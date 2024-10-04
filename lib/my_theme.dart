import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_alife/my_parette.dart';

ColorScheme _colorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: MyPalette.primary.color,
  onPrimary: MyPalette.onBackground.color,
  secondary: MyPalette.secondary.color,
  onSecondary: MyPalette.onBackground.color,
  tertiary: MyPalette.tertiary.color,
  onTertiary: MyPalette.onBackground.color,
  error: MyPalette.primary.color,
  onError: MyPalette.background.color,
  background: MyPalette.background.color,
  onBackground: MyPalette.onBackground.color,
  surface: MyPalette.background.color,
  onSurface: MyPalette.onBackground.color,
  surfaceVariant: MyPalette.surfaceVariant.color,
  onSurfaceVariant: MyPalette.onBackground.color,
  outline: MyPalette.outline.color,
);

final TextTheme _textTheme = GoogleFonts.montserratTextTheme();

final ThemeData themeData = ThemeData(
  colorScheme: _colorScheme,
  textTheme: _textTheme,
);

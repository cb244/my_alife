import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// https://www.happyhues.co/palettes/15
const _mainTextColor = Color(0xff33272a);
const _subTextColor = Color(0xff594a4e);
const _primaryColor = Color(0xffff8ba7);
const _secondaryColor = Color(0xffffc6c7);
const _tertiaryColor = Color(0xffc3f0ca);
const _backgroundColor = Color(0xfffaeee7);
const _surfaceVariantColor = Color(0xfffffffe);

ColorScheme _colorScheme = const ColorScheme(
  brightness: Brightness.light,
  primary: _primaryColor,
  onPrimary: _mainTextColor,
  secondary: _secondaryColor,
  onSecondary: _mainTextColor,
  tertiary: _tertiaryColor,
  onTertiary: _mainTextColor,
  error: _primaryColor,
  onError: _backgroundColor,
  background: _backgroundColor,
  onBackground: _mainTextColor,
  surface: _backgroundColor,
  onSurface: _mainTextColor,
  surfaceVariant: _surfaceVariantColor,
  onSurfaceVariant: _subTextColor,
);

final TextTheme _textTheme = GoogleFonts.montserratTextTheme();

final ThemeData themeData = ThemeData(
  colorScheme: _colorScheme,
  textTheme: _textTheme,
);

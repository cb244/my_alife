import 'package:flutter/material.dart';
import 'package:my_alife/my_parette.dart';

final ColorScheme colorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: MyPalette.primary.color,
  onPrimary: MyPalette.onBackground.color,
  secondary: MyPalette.secondary.color,
  onSecondary: MyPalette.onBackground.color,
  tertiary: MyPalette.tertiary.color,
  onTertiary: MyPalette.onBackground.color,
  error: MyPalette.primary.color,
  onError: MyPalette.background.color,
  surface: MyPalette.background.color,
  onSurface: MyPalette.onBackground.color,
  surfaceContainerHighest: MyPalette.surfaceVariant.color,
  onSurfaceVariant: MyPalette.onBackground.color,
  outline: MyPalette.outline.color,
);

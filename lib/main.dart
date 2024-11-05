import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_alife/my_app.dart';
import 'package:my_alife/my_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      theme: ThemeData(
        colorScheme: colorScheme,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: const MyApp(),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color _primaryGrey = Color(0xFF5A5A5A);
const Color _secondaryGreen = Color(0xFF64B57E);
const Color _tertiaryPurple = Color(0xFF543D98);

const Color _primaryColorLight = Colors.blue;
const Color _primaryColorDark = Colors.blueGrey;

const Color _accentColorLight = Colors.lightBlueAccent;
const Color _accentColorDark = Colors.tealAccent;

const Color _textColorLight = Colors.black;
const Color _textColorDark = Colors.white;

const double _fontSizeLarge = 20.0;
const double _fontSizeMedium = 16.0;
const double _fontSizeSmall = 12.0;

// Light theme
final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: const Color(0xFFFEF7FF), // App Bar
      onPrimary: const Color(0xFF414141),
      secondary: const Color(0xFF674FA3), // ElevatedButton
      onSecondary: const Color(0xFFF7F4FC),
      error: const Color(0xFFEFA39F), // SnackBar
      onError: const Color(0xff5c1713),
      background: const Color(0xFFD0C8E2), // Text Field
      onBackground: const Color(0xFF313532),
      surface: const Color(0xFF414141).withOpacity(0.1), // Card, Container
      onSurface: const Color(0xFF414141)),
  scaffoldBackgroundColor: const Color(0xFFFEF7FF),
  textTheme: GoogleFonts.cabinTextTheme(),
  useMaterial3: true,
  // textTheme: const TextTheme(
  //   headlineLarge: TextStyle(fontSize: _fontSizeLarge, color: _textColorLight),
  //   bodyText1: TextStyle(fontSize: _fontSizeMedium, color: _textColorLight),
  //   bodyText2: TextStyle(fontSize: _fontSizeSmall, color: _textColorLight),
  // ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

// Dark theme
final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: const Color(0xFFECECEC), // App Bar
      onPrimary: const Color(0xFF414141),
      secondary: const Color(0xFF0D67B5), // ElevatedButton
      onSecondary: const Color(0xFFF7F4FC),
      error: const Color(0xFFEFA39F), // SnackBar
      onError: const Color(0xff5c1713),
      background: const Color(0xFF414141).withOpacity(0.3), // Text Field
      onBackground: const Color(0xFF414141),
      surface: const Color(0xFF414141).withOpacity(0.1), // Card, Container
      onSurface: const Color(0xFF414141)),
  scaffoldBackgroundColor: const Color(0xFF1D1B20),
  textTheme: GoogleFonts.cabinTextTheme(),
  useMaterial3: true,
  // textTheme: const TextTheme(
  //   headlineLarge: TextStyle(fontSize: _fontSizeLarge, color: _textColorLight),
  //   bodyText1: TextStyle(fontSize: _fontSizeMedium, color: _textColorLight),
  //   bodyText2: TextStyle(fontSize: _fontSizeSmall, color: _textColorLight),
  // ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

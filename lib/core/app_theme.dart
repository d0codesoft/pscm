import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pscm/core/utils/colorExtention.dart';

class AppTheme {
  AppTheme._();

  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFFFFFF);
  static const Color nearlyBlue = Color(0xFF00B6F0);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);

  static const MaterialColor appcolor = MaterialColor(
    _appColorPrimaryValue,
    <int, Color>{
      50: Color(0xFFe9ebf6),
      100: Color(0xFFc7cbe9),
      200: Color(0xFFa2aad9),
      300: Color(0xFF7e89ca),
      400: Color(0xFF626ebf),
      500: Color(0xFF4855b4),
      600: Color(_appColorPrimaryValue),
      700: Color(0xFF39429d),
      800: Color(0xFF313991),
      900: Color(0xFF24277c),
    },
  );
  static const int _appColorPrimaryValue = 0xFF414daa;
  static const Color primaryColorTheme = Color(_appColorPrimaryValue);

  static ColorScheme colorSheme = ColorScheme.fromSeed(
      seedColor: '#27324C'.toColor(),
      primary: '#27324C'.toColor(),
      secondary: '#0D172E'.toColor(),
      brightness: Brightness.light
  );

  static TextTheme textTheme = TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
  );

  static TextStyle displayLarge = GoogleFonts.roboto(
    fontSize: 57,
    fontWeight: FontWeight.bold,
    color: darkerText
  );

  static TextStyle displayMedium = GoogleFonts.roboto(
      fontSize: 45,
      fontWeight: FontWeight.normal,
      color: darkerText
  );

  static TextStyle displaySmall = GoogleFonts.roboto(
      fontSize: 36,
      fontWeight: FontWeight.normal,
      color: darkerText
  );

  static TextStyle headlineLarge = GoogleFonts.roboto(
      fontSize: 32,
      fontWeight: FontWeight.normal,
      color: darkerText
  );

  static TextStyle headlineMedium = GoogleFonts.roboto(
      fontSize: 28,
      fontWeight: FontWeight.normal,
      color: darkerText
  );

  static TextStyle headlineSmall = GoogleFonts.roboto(
      fontSize: 24,
      fontWeight: FontWeight.normal,
      color: darkerText
  );

  static TextStyle titleLarge = GoogleFonts.roboto(
    fontSize: 22,
    letterSpacing: 0,
    color: darkerText,
  );

  static TextStyle titleMedium = GoogleFonts.roboto(
    fontSize: 16,
    letterSpacing: 0.15,
    color: darkerText,
  );

  static TextStyle titleSmall = GoogleFonts.roboto(
    fontSize: 14,
    letterSpacing: 0.1,
    color: darkerText,
  );

  static TextStyle bodyLarge = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 0.15,
    color: darkText,
  );

  static TextStyle bodyMedium = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.25,
    color: darkText,
  );

  static TextStyle bodySmall = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.4,
    color: darkText,
  );

  static TextStyle labelLarge = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.1,
    color: darkText,
  );

  static TextStyle labelMedium = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.5,
    color: darkText,
  );

  static TextStyle labelSmall = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 11,
    letterSpacing: 0.5,
    color: darkText,
  );
}
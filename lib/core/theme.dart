import 'dart:ui';

import 'package:flutter/material.dart';

enum Themes {
  //
  system("system"),
  light("light"),
  dark("dark");

  // Codification du theme
  final String code;

  const Themes(this.code);

  static List<Themes> list() => Themes.values;
}

/// Pour modifier les couleurs de base de l'application vous pouver agir sur :
/// [brownColor], [primary], [primaryLight], [primaryDark], [primaryStroke]
/// Vous n'avez pas besoin de modifier les autres couleurs, mais toutes fois vous / êtes libres d'appliquer les thèmes que vous voulez
class AppTheme {
  //
  /// private constructor which prevents the class from being instantiated.
  AppTheme._();

  // Primary
  static const Color primary = Color(0xFFF2A900);

  /// Primary Light // 0xFFF9EBC2 -> colorScheme.secondary
  static const Color primaryLight = Color(0xFFF9EBC2);

  /// Primary Light
  static const Color primaryDark = Color(0xFFC08507);

  /// Couleur primaire bordure
  static const Color primaryStroke = Color(0xFFFFD573);

  /// Couleur blanc
  static const Color whiteColor = Color(0xFFffffff);

  /// Couleur blanc
  static const Color blackColor = Color(0xFF000000);

  /// Couleur neural 01
  static const Color neural01Color = Color(0xFFE6E4E2);

  /// Couleur neural 02
  static const Color neural02Color = Color(0xFFBDBDBB);

  /// Couleur neural 03
  static const Color neural03Color = Color(0xFF8B887E);

  /// Couleur neural 04
  static const Color neural04Color = Color(0xFF615D52);

  /// Couleur neural 05
  static const Color neural05Color = Color(0xFF5C5451);

  /// System/error
  static const Color systemErrorColor = Color(0xFFFA5A25);

  /// System blue for cancel btn
  static const Color systemBlueColor = Color(0xFF007AFF);

  /// System green
  static const Color successColor = Color(0xFF46A93D);

  /// Gray
  static const Color gray = Color(0xFFA1A5AC);

  static const TextStyle _defaultStyleLight = TextStyle(
    color: blackColor,
    fontFamily: 'Inter',
  );

  static const TextStyle _defaultStyleDark = TextStyle(
    color: whiteColor,
    fontFamily: 'Inter',
  );

  static const iconButtonStyle = ButtonStyle(
    backgroundColor: 
      WidgetStatePropertyAll(Colors.transparent),
    foregroundColor: 
      WidgetStatePropertyAll(primaryDark),
    overlayColor:  
      WidgetStatePropertyAll(primaryLight),
  );

  // primary btn height
  static const double btnNormalHeight = 56;
  // primary small btn height
  static const double btnSmallHeight = 38;

  /// Light theme data
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: whiteColor,
      foregroundColor: blackColor,
      titleTextStyle: TextStyle(
        color: blackColor,
      ),
      elevation: 0,
    ),
    brightness: Brightness.light,
    primaryColor: primary,
    primaryColorDark: primaryDark,
    secondaryHeaderColor: primaryLight,
    cardColor: const Color(0xFFFAF8F6),
    scaffoldBackgroundColor: whiteColor,
    dialogBackgroundColor: whiteColor,
    dialogTheme: const DialogTheme(
      surfaceTintColor: whiteColor,
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: blackColor,
      secondary: primaryLight,
      onSecondary: blackColor,
      error: systemErrorColor,
      onError: blackColor,
      surface: whiteColor,
      onSurface: blackColor,
      // surface: Color(0xFFdfe2eb),
      // onSurface: Color(0xFF43474e),
    ),
    buttonTheme: const ButtonThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: blackColor,
        secondary: primaryLight,
        onSecondary: blackColor,
        error: systemErrorColor,
        onError: blackColor,
        surface: whiteColor,
        onSurface: blackColor,
      ),
    ),
    primaryIconTheme: const IconThemeData(
      color: primary,
    ),
    textTheme: TextTheme(
      // Default / Regular / LargeTitle (Semi)
      titleLarge: _defaultStyleLight.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
      // Default / Regular / LargeTitle
      titleMedium: _defaultStyleLight.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w400,
      ),
      // Default / Regular / Title1 et Default / Regular / Title1 (Semi)
      titleSmall: _defaultStyleLight.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      headlineLarge: _defaultStyleLight.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: _defaultStyleLight.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      // Default / Regular / Body (Med) / Headline
      headlineSmall: _defaultStyleLight.copyWith(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        height: 1.53, //26
      ),
      // Default / Regular / Body
      bodyLarge: _defaultStyleLight.copyWith(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        height: 1.5, // 26/17
      ),
      bodyMedium: _defaultStyleLight.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      // Subheadline (med)
      bodySmall: _defaultStyleLight.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      // Subheadline
      displayLarge: _defaultStyleLight.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.4, // 20/15
      ),
      displayMedium: _defaultStyleLight.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      // Default / Regular / Footnote
      displaySmall: _defaultStyleLight.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: neural04Color,
        height: 1.4, // 18/13
      ),
      labelLarge: _defaultStyleLight.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      labelMedium: _defaultStyleLight.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w400,
      ),
    ),
    cardTheme: const CardTheme(
      color: Color(0xFFFAF8F6),
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            15.0,
          ),
          topRight: Radius.circular(
            15.0,
          ),
        ),
      ),
    ),
    // Style des champs inputs de formulaire
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 5.0),
      fillColor: Color(0xFFFAF8F6),
      filled: true,
      border: InputBorder.none,
      //floatingLabelStyle: textstyle(color: colors.red),
      floatingLabelStyle: TextStyle(
        color: neural04Color,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        //height: 1, // 26/17
      ),
      labelStyle: TextStyle(
        color: neural03Color,
        fontSize: 17,
      ),
      hintStyle: TextStyle(
        color: neural02Color,
        fontSize: 17,
      ),
      //constraints: BoxConstraints(maxHeight: 48),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        //borderSide: BorderSide.none,
        borderSide: BorderSide(
          color: primary,
        ),
      ),
      //border: InputBorder.none,
      errorMaxLines: 3,
      errorStyle: TextStyle(
        color: systemErrorColor,
        fontSize: 12,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        //borderSide: BorderSide.none,
        borderSide: BorderSide(
          color: systemErrorColor,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        //borderSide: BorderSide.none,
        borderSide: BorderSide(
          color: systemErrorColor,
        ),
      ),
      // icon color
      suffixIconColor: Color(0xFF8b887e),
    ),
    // Bouton elevated
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return const Color(0xFFE1A009);
            } else if (states.contains(WidgetState.disabled)) {
              return const Color(0xFFF5F5F1);
            } else {
              return primary; // Defer to the widget's default.
            }
          },
        ),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return neural03Color;
            } else {
              return blackColor; // Defer to the widget's default.
            }
          },
        ),
        minimumSize: const WidgetStatePropertyAll(Size.fromHeight(56)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        elevation: const WidgetStatePropertyAll(0.0),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            color: blackColor, // Text color
            fontSize: 17,
            fontWeight: FontWeight.w600, // Text size
          ),
        ),
      ),
    ),
    // Bouton link
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
        foregroundColor: const WidgetStatePropertyAll(primaryDark),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(
            color: primaryDark,
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        ),
        overlayColor:
            WidgetStateProperty.all<Color>(primaryLight),
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: const WidgetStatePropertyAll(Size(55, 26)),
      ),
    ),
    // Switch theme
    switchTheme: SwitchThemeData(
      thumbColor: const WidgetStatePropertyAll(whiteColor),
      trackColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return primary;
          } else {
            return neural01Color;
          }
        },
      ),
      trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
    ),
    // Filled button theme
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        minimumSize: const WidgetStatePropertyAll(Size.fromHeight(56)),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return neural03Color;
            } else {
              return blackColor; // Defer to the widget's default.
            }
          },
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            color: blackColor, // Text color
            fontSize: 17,
            fontWeight: FontWeight.w600, // Text size
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    ),
    // Snackbar
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: systemErrorColor,
      insetPadding: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
    ),
    // Checkbox theme
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      checkColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          return whiteColor;
        },
      ),
      side: const BorderSide(
        color: neural02Color,
        width: 2,
        style: BorderStyle.solid,
      ),
    ),
    // Chip
    chipTheme: ChipThemeData(
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      labelStyle: const TextStyle(
        color: blackColor, // Text color
        fontSize: 14,
        fontWeight: FontWeight.w500, // Text size
      ),
    ),
  );

  /// Dark theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: whiteColor,
      titleTextStyle: TextStyle(
        color: whiteColor,
      ),
      elevation: 0,
    ),
    primaryColor: primary,
    primaryColorDark: primaryDark,
    secondaryHeaderColor: primaryStroke,
    cardColor: const Color(0xFF1E1E1E),
    scaffoldBackgroundColor: const Color(0xFF2E2B26),
    dialogBackgroundColor: const Color(0xFF2E2B26),
    dialogTheme: const DialogTheme(
      surfaceTintColor: Color(0xFF2E2B26),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: primary,
      onPrimary: whiteColor,
      secondary: primaryStroke,
      onSecondary: whiteColor,
      error: systemErrorColor,
      onError: whiteColor,
      surface: Color(0xFF121212),
      onSurface: whiteColor,
    ),
    buttonTheme: const ButtonThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: primary,
        onPrimary: whiteColor,
        secondary: primaryStroke,
        onSecondary: whiteColor,
        error: systemErrorColor,
        onError: whiteColor,
        surface: Color(0xFF121212),
        onSurface: whiteColor,
        // surface: Color(0xFF43474e),
        // onSurface: Color(0xFFdfe2eb),
      ),
    ),
    primaryIconTheme: const IconThemeData(
      color: primary,
    ),
    textTheme: TextTheme(
      // Default / Regular / LargeTitle (Semi)
      titleLarge: _defaultStyleDark.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
      // Default / Regular / LargeTitle
      titleMedium: _defaultStyleDark.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w400,
      ),
      // Default / Regular / Title1 et Default / Regular / Title1 (Semi)
      titleSmall: _defaultStyleDark.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      headlineLarge: _defaultStyleDark.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: _defaultStyleDark.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      // Default / Regular / Body (Med) / Headline
      headlineSmall: _defaultStyleDark.copyWith(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        height: 1.53, //26
      ),
      // Default / Regular / Body
      bodyLarge: _defaultStyleDark.copyWith(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        height: 1.5, // 26/17
      ),
      bodyMedium: _defaultStyleDark.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      // Subheadline (med)
      bodySmall: _defaultStyleDark.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      // Subheadline
      displayLarge: _defaultStyleDark.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.4, // 20/15
      ),
      displayMedium: _defaultStyleDark.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      // Default / Regular / Footnote
      displaySmall: _defaultStyleDark.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: neural04Color,
        height: 1.4, // 18/13
      ),
      labelLarge: _defaultStyleDark.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      labelMedium: _defaultStyleDark.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w400,
      ),
    ),
    cardTheme: const CardTheme(
      color: Color(0xFF1E1E1E),
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF121212),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            15.0,
          ),
          topRight: Radius.circular(
            15.0,
          ),
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 5.0),
      fillColor: Color(0xFF333333),
      filled: true,
      border: InputBorder.none,
      //floatingLabelStyle: textstyle(color: colors.red),
      floatingLabelStyle: TextStyle(
        color: Color(0xFF9E9E9E),
        fontSize: 13,
        fontWeight: FontWeight.w400,
        //height: 1, // 26/17
      ),
      labelStyle: TextStyle(
        color: Color(0xFF9E9E9E),
        fontSize: 17,
      ),
      hintStyle: TextStyle(
        color: Color(0xFFEEEEEE),
        fontSize: 17,
      ),
      //constraints: BoxConstraints(maxHeight: 48),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        //borderSide: BorderSide.none,
        borderSide: BorderSide(
          color: primary,
        ),
      ),
      //border: InputBorder.none,
      errorMaxLines: 3,
      errorStyle: TextStyle(
        color: systemErrorColor,
        fontSize: 12,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        //borderSide: BorderSide.none,
        borderSide: BorderSide(
          color: systemErrorColor,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        //borderSide: BorderSide.none,
        borderSide: BorderSide(
          color: systemErrorColor,
        ),
      ),
      // icon color
      suffixIconColor: Color(0xFFB1ADA0),
    ),
    // Bouton elevated
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return const Color(0xFFE1A009);
            } else if (states.contains(WidgetState.disabled)) {
              return const Color(0xFF2E2E2E);
            } else {
              return primary; // Defer to the widget's default.
            }
          },
        ),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return const Color(0xFFB1ADA0); 
            } else {
              return const Color(0xFFFFFFFF);
            }
          },
        ),
        minimumSize: const WidgetStatePropertyAll(Size.fromHeight(56)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        elevation: const WidgetStatePropertyAll(0.0),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            color: whiteColor, // Text color
            fontSize: 17,
            fontWeight: FontWeight.w600, // Text size
          ),
        ),
      ),
    ),
    // Bouton link
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
        foregroundColor: const WidgetStatePropertyAll(primaryDark),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(
            color: primaryDark,
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        ),
        overlayColor:
            WidgetStateProperty.all<Color>(primaryLight),
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: const WidgetStatePropertyAll(Size(55, 26)),
      ),
    ),
    // Switch theme
    switchTheme: SwitchThemeData(
      thumbColor: const WidgetStatePropertyAll(Color(0xFF1E1E1E)),
      trackColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return primary;
          } else {
            return neural04Color;
          }
        },
      ),
      trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
    ),
    // Filled button theme
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        minimumSize: const WidgetStatePropertyAll(Size.fromHeight(56)),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return const Color(0xFFB1ADA0); 
            } else {
              return whiteColor;
            }
          },
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            color: whiteColor, // Text color
            fontSize: 17,
            fontWeight: FontWeight.w600, // Text size
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    ),
    // Snackbar
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: systemErrorColor,
      insetPadding: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
    ),
    // Checkbox theme
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      checkColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          return const Color(0xFF121212);
        },
      ),
      side: const BorderSide(
        color: neural02Color,
        width: 2,
        style: BorderStyle.solid,
      ),
    ),
    // Chip
    chipTheme: ChipThemeData(
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      labelStyle: const TextStyle(
        color: whiteColor, // Text color
        fontSize: 14,
        fontWeight: FontWeight.w500, // Text size
      ),
    ),
  );

  /// Méthode qui retourne un theme demandé
  static ThemeData get(String? code) {
    // Clair
    if (code == Themes.light.code) {
      return lightTheme;
    }
    // Sombre
    else if (code == Themes.dark.code) {
      return darkTheme;
    }
    // Système
    else {
      Brightness systemBrightness = 
        PlatformDispatcher.instance.platformBrightness;
      return systemBrightness == Brightness.light 
        ? lightTheme 
        : darkTheme;
      // return lightTheme;
    }
  }
}

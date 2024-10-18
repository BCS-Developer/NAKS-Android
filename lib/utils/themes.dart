// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class Themes {
  static const Color primaryColor = Color(0xffFF3A43);
  static const Color darkPrimaryColor = Color(0xffaa6a03);
  static const double elevation = 4;
  static const double cardRadius = 4;
  static const String fontFamily = 'Poppins';
  static const Color black_color = Colors.black;
  static const Color black_color12 = Colors.black12;
  static const Color white_color = Colors.white;
  static const Color red_color = Colors.red;
  static const Color brown_color = Colors.brown;
  static const Color bottomNavigationBar = Color.fromARGB(255, 224, 223, 217);
  static const Color bottombarselectedicon = Colors.black;
  static const Color bottombarunselectedicon = Colors.grey;

  static const Color categoryName_background =
      Color.fromARGB(255, 235, 213, 19);
  static const Color like_share = Color(0xffFF3A43);
  static const Color back_arrow = Color(0xffFF3A43);
  static const textfieldText = TextStyle(
    fontFamily: Themes.fontFamily,
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
  );
  static const appBarHeader = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 22.0,
      fontWeight: FontWeight.w600,
      color: Themes.red_color);

  static const appbarDoneButton = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      fontFamily: Themes.fontFamily,
      color: Themes.red_color);

  static const HomePageText = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      fontFamily: Themes.fontFamily,
      color: Themes.red_color);

  static const MenuTitleTextStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    fontFamily: 'Poppins',
  );

  static const homepageCategoryName = TextStyle(
      color: Colors.white,
      fontFamily: Themes.fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 16);

  static const textArticle = TextStyle(
    fontFamily: Themes.fontFamily,
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static const savebuttonTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins',
      color: Themes.red_color);
  static const loginbuttonTextStyle = TextStyle(
    color: Themes.red_color,
    fontWeight: FontWeight.w400,
    fontSize: 18,
    fontFamily: Themes.fontFamily,
  );

  static const TextStyle loginpagetext = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.w600,
    fontFamily: Themes.fontFamily,
  );
  static const TextStyle homepageAppname = TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.w600,
      fontFamily: Themes.fontFamily,
      color: Themes.red_color);

  // OTP Page
  static const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
  static const fillColor = Color.fromRGBO(243, 246, 249, 0);
  static const borderColor = Color.fromRGBO(10, 11, 11, 0.4);

  static final defaultPinTheme = PinTheme(
    width: 50,
    height: 50,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
      border: Border.all(color: borderColor),
    ),
  );

  static final Color _lightFocusColor = Colors.black.withOpacity(0);
  static final Color _darkFocusColor = Colors.white.withOpacity(0);
  //theme data
  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);
  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
        colorScheme: colorScheme,
        canvasColor: colorScheme.background,
        scaffoldBackgroundColor: colorScheme.background,
        highlightColor: Colors.transparent,
        focusColor: focusColor,
        textTheme: TextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primary,
        ));
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xffFF3A43),
    onPrimary: Colors.red,
    secondary: Color.fromRGBO(23, 171, 144, 1),
    onSecondary: Color(0xFF322942),
    error: Color.fromARGB(255, 235, 213, 19),
    onError: Color(0xffFF3A43),
    background: Colors.white,
    onBackground: Colors.white,
    surface: Color(0xFFFAFBFB),
    onSurface: Colors.black,
    brightness: Brightness.light,
    tertiary: Color.fromARGB(255, 6, 124, 36),
  );
  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFFB9B9B9),
    onPrimary: Colors.red,
    secondary: Color.fromRGBO(23, 171, 144, 1),
    onSecondary: Colors.white,
    background: Colors.black,
    onBackground: Color(0x0DFFFFFF),
    surface: Color(0xFF333333),
    onSurface: Colors.white,
    error: Color.fromARGB(255, 235, 213, 19),
    onError: Color(0xFF333333),
    brightness: Brightness.dark,
    tertiary: Color(0xffFF3A43),
  );
}

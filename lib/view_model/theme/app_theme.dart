import 'package:flutter/material.dart';
import 'package:morphydex/res/app_color.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: bgColor,
    appBarTheme: const AppBarTheme(
      // color: primaryColor,
      backgroundColor: primaryColor,
    ),
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      onPrimary: Colors.white,
      secondary: Colors.blue, // Adjust this to your secondary color
      onSecondary: Colors.white,
      error: Colors.red, // Adjust this to your error color
      onError: Colors.white,
      surface: Colors.white, // Adjust this to your surface color
      onSurface: Colors.black,
    ),
    // Add more theme configurations as needed
  );

  // You can define a dark theme as well if needed
  // static ThemeData darkTheme = ThemeData.dark().copyWith(
  //   primaryColor: primaryColor,
  //   backgroundColor: bgColor,
  //   scaffoldBackgroundColor: bgColor,
  //   appBarTheme: AppBarTheme(
  //     color: primaryColor,
  //   ),
  //   // Add more dark theme configurations as needed
  // );
}

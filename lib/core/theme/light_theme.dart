import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(primaryContainer: Color(0xFFFFFFFF), secondary: Color(0xFF3A4640)),
  scaffoldBackgroundColor: Color(0xFFF6F7F9),
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black),
    centerTitle: false,
    titleTextStyle: TextStyle(color: Colors.black, fontSize: AppSizes.sp20),
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFF15B86C);
      }
      return Colors.white; // check
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.black; // check
      }
      return Color(0xFF9E9E9E);
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return Color(0xFF9E9E9E);
    }),
    trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return 0;
      }
      return 2;
    }),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Color(0xFF15B86C)),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      textStyle: WidgetStateProperty.all(TextStyle(fontSize: AppSizes.sp14, fontWeight: FontWeight.w500)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Colors.black),
      // textStyle: WidgetStateProperty.all(TextStyle(fontSize: AppSizes.sp14, fontWeight: FontWeight.w500)),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF15B86C),
    foregroundColor: Colors.white,
    extendedTextStyle: TextStyle(fontSize: AppSizes.sp14, fontWeight: FontWeight.w500),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: AppSizes.sp32,
      fontWeight: FontWeight.w400,
      color: Color(0xFF161F1B),
      overflow: TextOverflow.ellipsis,
    ),
    displayMedium: TextStyle(
      fontSize: AppSizes.sp28,
      fontWeight: FontWeight.w400,
      color: Color(0xFF161F1B),
      overflow: TextOverflow.ellipsis,
    ),
    displaySmall: TextStyle(
      fontSize: AppSizes.sp24,
      fontWeight: FontWeight.w400,
      color: Color(0xFF161F1B),
      overflow: TextOverflow.ellipsis,
    ),
    labelLarge: TextStyle(color: Colors.black, fontSize: AppSizes.sp20, overflow: TextOverflow.ellipsis),
    labelMedium: TextStyle(color: Colors.black, fontSize: AppSizes.sp16, overflow: TextOverflow.ellipsis),
    titleLarge: TextStyle(
      color: Color(0xFF6A6A6A),
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xFF6A6A6A),
      overflow: TextOverflow.ellipsis,
    ),
    titleMedium: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
      overflow: TextOverflow.ellipsis,
    ),
    titleSmall: TextStyle(
      color: Color(0xFF3A4640),
      fontSize: AppSizes.sp14,
      fontWeight: FontWeight.w400,
      overflow: TextOverflow.ellipsis,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
    filled: true,
    fillColor: Color(0xFFFFFFFF),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6)),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red),
    ),
    focusColor: Color(0xFFD1DAD6),
  ),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xFFD1DAD6), width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  iconTheme: IconThemeData(color: Color(0xFF3A4640), size: 20),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
      overflow: TextOverflow.ellipsis,
    ),
  ),
  dividerTheme: DividerThemeData(color: Color(0xFFD1DAD6), thickness: 1),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Color(0xFFD1DAD6),
    selectionHandleColor: Colors.black,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Color(0xFFF6F7F9),
    selectedItemColor: Color(0xFF15B86C),
    unselectedItemColor: Color(0xFF3A4640),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    elevation: 10,
    shadowColor: Color(0xFF15B86C),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: Color(0xFF15B86C), width: 2),
    ),
    color: Color(0xFFF6F7F9),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(
        color: Colors.black,
        fontSize: AppSizes.sp16,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  ),
);

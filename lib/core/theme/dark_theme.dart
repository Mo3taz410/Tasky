import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    primaryContainer: Color(0xFF282828),
    secondary: Color(0xFFC6C6C6),
  ),
  scaffoldBackgroundColor: Color(0xFF181818),
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.white),
    centerTitle: false,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFF15B86C);
      }
      return Colors.white;
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
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
      textStyle: WidgetStateProperty.all(
        TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Colors.white),
      // textStyle: WidgetStateProperty.all(TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF15B86C),
    foregroundColor: Colors.white,
    extendedTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      color: Color(0xFFFFFCFC),
      overflow: TextOverflow.ellipsis,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: Color(0xFFFFFCFC),
      overflow: TextOverflow.ellipsis,
    ),
    displaySmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: Color(0xFFFFFCFC),
      overflow: TextOverflow.ellipsis,
    ),
    labelLarge: TextStyle(
      color: Colors.white,
      fontSize: 20,
      overflow: TextOverflow.ellipsis,
    ),
    labelMedium: TextStyle(
      color: Colors.white,
      fontSize: 16,
      overflow: TextOverflow.ellipsis,
    ),
    // for done tasks
    titleLarge: TextStyle(
      color: Color(0xFFA0A0A0),
      fontSize: 16,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xFFA0A0A0),
      overflow: TextOverflow.ellipsis,
    ),
    titleMedium: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: 16,
      fontWeight: FontWeight.w400,
      overflow: TextOverflow.ellipsis,
    ),
    titleSmall: TextStyle(
      color: Color(0xFFC6C6C6),
      fontSize: 14,
      fontWeight: FontWeight.w400,
      overflow: TextOverflow.ellipsis,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
    filled: true,
    fillColor: Color(0xFF282828),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xFF6E6E6E), width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  iconTheme: IconThemeData(color: Color(0xFFC6C6C6), size: 20),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: 16,
      fontWeight: FontWeight.w400,
      overflow: TextOverflow.ellipsis,
    ),
  ),
  dividerTheme: DividerThemeData(color: Color(0xFF6E6E6E), thickness: 1),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Colors.black,
    selectionHandleColor: Colors.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.transparent,
    selectedItemColor: Color(0xFF15B86C),
    unselectedItemColor: Color(0xFFC6C6C6),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    elevation: 10,
    shadowColor: Color(0xFF15B86C),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: Color(0xFF15B86C), width: 2),
    ),
    color: Color(0xFF282828),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  ),
);

import 'package:flutter/material.dart';
import 'package:tasky/features/navigation/main_screen.dart';
import 'package:tasky/features/welcome/welcome_screen.dart';
import 'core/services/shared_preferences_manager.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'core/theme/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesManager().init();
  ThemeController().init();
  final String? name = SharedPreferencesManager().getString('name');
  runApp(MyApp(name: name));
}

class MyApp extends StatelessWidget {
  final String? name;

  const MyApp({super.key, this.name});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeController.themeNotifier,
      builder: (BuildContext context, ThemeMode themeMode, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tasky',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: name == null ? WelcomeScreen() : MainScreen(),
        );
      },
    );
  }
}

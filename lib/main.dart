import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/navigation/main_screen.dart';
import 'package:tasky/features/tasks/controllers/tasks_controller.dart';
import 'package:tasky/features/welcome/welcome_screen.dart';
import 'core/constants/storage_keys.dart';
import 'core/services/shared_preferences_manager.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'core/theme/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesManager().init();
  ThemeController().init();
  final String? name = SharedPreferencesManager().getString(
    StorageKeys.userName,
  );
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
        return ChangeNotifierProvider<TasksController>(
          create: (_) {
            return TasksController()..loadTasks();
          },
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Tasky',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeMode,
            home: name == null ? WelcomeScreen() : MainScreen(),
          ),
        );
      },
    );
  }
}

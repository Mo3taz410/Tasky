import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/app_sizes.dart';
import '../tasks/screens/completed_tasks_screen.dart';
import '../home/screens/home_screen.dart';
import '../profile/profile_screen.dart';
import '../tasks/screens/todo_tasks_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = [HomeScreen(), ToDoTasksScreen(), CompletedTasksScreen(), ProfileScreen()];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.w16, vertical: AppSizes.h16),
          child: screens[currentIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: _buildSvgPicture('assets/icons/home.svg', 0), label: 'Home'),
          BottomNavigationBarItem(icon: _buildSvgPicture('assets/icons/to_do.svg', 1), label: 'To Do'),
          BottomNavigationBarItem(icon: _buildSvgPicture('assets/icons/completed.svg', 2), label: 'Completed'),
          BottomNavigationBarItem(icon: _buildSvgPicture('assets/icons/profile.svg', 3), label: 'Profile'),
        ],
      ),
    );
  }

  SvgPicture _buildSvgPicture(String path, int index) => SvgPicture.asset(
    path,
    colorFilter: ColorFilter.mode(
      currentIndex == index ? Color(0xFF15B86C) : Theme.of(context).iconTheme.color!,
      BlendMode.srcIn,
    ),
  );
}

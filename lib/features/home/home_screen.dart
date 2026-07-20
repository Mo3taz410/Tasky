import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/home/components/achieved_tasks.dart';
import 'package:tasky/features/home/components/high_priority_tasks.dart';
import '../../core/widgets/custom_svg_picture.dart';
import 'components/sliver_tasks_list.dart';
import '../add_task/add_task_screen.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (_) {
        return HomeController()..init();
      },

      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Selector<HomeController, String?>(
                        builder:
                            (
                              BuildContext context,
                              String? profilePicturePath,
                              Widget? child,
                            ) {
                              return CircleAvatar(
                                radius: 20,
                                backgroundImage: profilePicturePath != null
                                    ? FileImage(File(profilePicturePath))
                                    : AssetImage('assets/images/person.png'),
                              );
                            },
                        selector:
                            (BuildContext context, HomeController controller) =>
                                controller.profilePicturePath,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Selector<HomeController, String>(
                            builder:
                                (
                                  BuildContext context,
                                  String name,
                                  Widget? child,
                                ) {
                                  return Text(
                                    'Good Evening, $name',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                    overflow: TextOverflow.ellipsis,
                                  );
                                },
                            selector:
                                (
                                  BuildContext context,
                                  HomeController controller,
                                ) => controller.name,
                          ),
                          Text(
                            'One task at a time.One step closer.',
                            style: Theme.of(context).textTheme.titleSmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Yuhuu ,Your work Is',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Row(
                    children: [
                      Text(
                        'almost done ! ',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      CustomSvgPicture.withoutColor(
                        path: 'assets/icons/waving_hand.svg',
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  AchievedTasks(),
                  SizedBox(height: 8),
                  HighPriorityTasks(),
                  SizedBox(height: 24),
                  Text(
                    'My Tasks',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            SliverTasksList(),
          ],
        ),
        floatingActionButton: SizedBox(
          height: 40,
          child: Builder(
            builder: (BuildContext context) {
              return FloatingActionButton.extended(
                backgroundColor: Color(0xFF15B86C),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onPressed: () async {
                  final bool? result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddTaskScreen()),
                  );
                  result != null && result
                      ? context.read<HomeController>().loadTasks()
                      : null;
                },
                label: Text('Add New Task'),
                icon: Icon(Icons.add),
              );
            },
          ),
        ),
      ),
    );
  }
}

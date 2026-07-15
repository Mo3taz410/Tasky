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
      create: (BuildContext context) {
        return HomeController();
      },
      child: Consumer<HomeController>(
        builder: (BuildContext context, value, Widget? child) {
          final controller = context.read<HomeController>()..init();
          return Scaffold(
            body: value.isLoading
                ? Center(child: CircularProgressIndicator())
                : CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      value.profilePicturePath != null
                                      ? FileImage(
                                          File(value.profilePicturePath!),
                                        )
                                      : AssetImage('assets/images/person.png'),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Good Evening, ${value.name}',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      'One task at a time.One step closer.',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleSmall,
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
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displayLarge,
                                ),
                                CustomSvgPicture.withoutColor(
                                  path: 'assets/icons/waving_hand.svg',
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            AchievedTasks(
                              completedTasks: value.completedTasks,
                              totalTasks: value.tasks.length,
                            ),
                            SizedBox(height: 8),
                            HighPriorityTasks(
                              highPriorityTasks: value.tasks
                                  .where((element) => element.isHighPriority)
                                  .toList(),
                              onChanged: (bool? value, int index) async {
                                controller.isCompleted(value, index);
                              },
                              refresh: controller.loadTasks,
                            ),
                            SizedBox(height: 24),
                            Text(
                              'My Tasks',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                      SliverTasksList(
                        tasks: value.tasks,
                        onChanged: (bool? value, int index) {
                          controller.isCompleted(value, index);
                        },
                        onDelete: (int id) {
                          controller.deleteTask(id);
                        },
                        onEdit: () {
                          controller.loadTasks();
                        },
                      ),
                    ],
                  ),
            floatingActionButton: SizedBox(
              height: 40,
              child: FloatingActionButton.extended(
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
                  result != null && result ? controller.loadTasks() : null;
                },
                label: Text('Add New Task'),
                icon: Icon(Icons.add),
              ),
            ),
          );
        },
      ),
    );
  }
}

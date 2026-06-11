import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tasky/features/home/components/achieved_tasks.dart';
import 'package:tasky/features/home/components/high_priority_tasks.dart';

import '../../core/services/shared_preferences_manager.dart';
import '../../core/widgets/custom_svg_picture.dart';
import '../../models/task_model.dart';
import 'components/sliver_tasks_list.dart';
import '../add_task/add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final String name;
  String? profilePicturePath;
  bool isLoading = true;
  List<TaskModel> tasks = [];
  int completedTasks = 0;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _loadTasks();
  }

  void _loadUserInfo() async {
    profilePicturePath = SharedPreferencesManager().getString(
      'profile_picture',
    );
    name = SharedPreferencesManager().getString('name') ?? "";
    isLoading = false;
    setState(() {});
  }

  void _loadTasks() async {
    final String? getTasks = SharedPreferencesManager().getString('tasks');
    if (getTasks == null) return;
    final List<dynamic> decodedList = jsonDecode(getTasks);
    tasks = decodedList.map((e) => TaskModel.fromJson(e)).toList();
    completedTasks = tasks.where((element) => element.isCompleted).length;
    setState(() {});
  }

  isCompleted(bool? value, int index) async {
    setState(() {
      tasks[index].isCompleted = value!;
      completedTasks = tasks.where((element) => element.isCompleted).length;
    });
    final updatedTasks = tasks.map((e) => e.toJson()).toList();
    await SharedPreferencesManager().setString(
      'tasks',
      jsonEncode(updatedTasks),
    );
  }

  _deleteTask(int id) async {
    setState(() {
      tasks.removeWhere((task) => task.id == id);
    });
    final updatedTasks = tasks.map((e) => e.toJson()).toList();
    await SharedPreferencesManager().setString(
      'tasks',
      jsonEncode(updatedTasks),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
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
                            backgroundImage: profilePicturePath != null
                                ? FileImage(File(profilePicturePath!))
                                : AssetImage('assets/images/person.png'),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Good Evening, $name',
                                style: Theme.of(context).textTheme.titleMedium,
                                overflow: TextOverflow.ellipsis,
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
                      AchievedTasks(
                        completedTasks: completedTasks,
                        totalTasks: tasks.length,
                      ),
                      SizedBox(height: 8),
                      HighPriorityTasks(
                        highPriorityTasks: tasks
                            .where((element) => element.isHighPriority)
                            .toList(),
                        onChanged: (bool? value, int index) async {
                          isCompleted(value, index);
                        },
                        refresh: _loadTasks,
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
                  tasks: tasks,
                  onChanged: (bool? value, int index) {
                    isCompleted(value, index);
                  },
                  onDelete: (int id) {
                    _deleteTask(id);
                  },
                  onEdit: () {
                    _loadTasks();
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
            result != null && result ? _loadTasks() : null;
          },
          label: Text('Add New Task'),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
}

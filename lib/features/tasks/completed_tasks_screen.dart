import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';

import '../../core/services/shared_preferences_manager.dart';
import '../../core/components/tasks_list.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreen();
}

class _CompletedTasksScreen extends State<CompletedTasksScreen> {
  List<TaskModel> completedTasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  _deleteTask(int id) async {
    List<TaskModel> tasks = [];
    final String? getTasks = SharedPreferencesManager().getString('tasks');
    if (getTasks == null) return;
    final List<dynamic> decodedList = jsonDecode(getTasks);
    tasks = decodedList.map((e) => TaskModel.fromJson(e)).toList();
    tasks.removeWhere((task) => task.id == id);
    setState(() {
      completedTasks.removeWhere((task) => task.id == id);
    });
    final updatedTasks = tasks.map((e) => e.toJson()).toList();
    await SharedPreferencesManager().setString(
      'tasks',
      jsonEncode(updatedTasks),
    );
  }

  void _loadTasks() async {
    final String? getTasks = SharedPreferencesManager().getString('tasks');
    if (getTasks == null) return;
    final List<dynamic> decodedList = jsonDecode(getTasks);
    completedTasks = decodedList
        .map((e) => TaskModel.fromJson(e))
        .where((element) => element.isCompleted)
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Completed Tasks', style: Theme.of(context).textTheme.labelLarge),
        SizedBox(height: 20),
        Expanded(
          child: TasksList(
            tasks: completedTasks,
            onChanged: (bool? value, int index) async {
              setState(() {
                completedTasks[index].isCompleted = value!;
              });
              final allTasks = SharedPreferencesManager().getString('tasks');
              if (allTasks == null) return;
              List<TaskModel> allTasksList = (jsonDecode(allTasks) as List)
                  .map((e) => TaskModel.fromJson(e))
                  .toList();
              final taskIndex = allTasksList.indexWhere(
                (e) => e.id == completedTasks[index].id,
              );
              allTasksList[taskIndex] = completedTasks[index];
              await SharedPreferencesManager().setString(
                'tasks',
                jsonEncode(allTasksList),
              );
              _loadTasks();
            },
            onDelete: (int id) {
              _deleteTask(id);
            },
            onEdit: () {
              _loadTasks();
            },
          ),
        ),
      ],
    );
  }
}

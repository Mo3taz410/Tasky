import 'dart:convert';
import 'package:flutter/material.dart';
import '../../core/services/shared_preferences_manager.dart';
import '../../models/task_model.dart';
import '../../core/components/tasks_list.dart';

class HighPriorityTasksScreen extends StatefulWidget {
  const HighPriorityTasksScreen({super.key});

  @override
  State<HighPriorityTasksScreen> createState() =>
      _HighPriorityTasksScreenState();
}

class _HighPriorityTasksScreenState extends State<HighPriorityTasksScreen> {
  List<TaskModel> highPriorityTasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    final String? getTasks = SharedPreferencesManager().getString('tasks');
    if (getTasks == null) return;
    final List<dynamic> decodedList = jsonDecode(getTasks);
    highPriorityTasks = decodedList
        .map((e) => TaskModel.fromJson(e))
        .where((element) => element.isHighPriority)
        .toList();
    setState(() {});
  }

  _deleteTask(int id) async {
    List<TaskModel> tasks = [];
    final String? getTasks = SharedPreferencesManager().getString('tasks');
    if (getTasks == null) return;
    final List<dynamic> decodedList = jsonDecode(getTasks);
    tasks = decodedList.map((e) => TaskModel.fromJson(e)).toList();
    tasks.removeWhere((task) => task.id == id);
    setState(() {
      highPriorityTasks.removeWhere((task) => task.id == id);
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
      appBar: AppBar(title: Text('High Priority Tasks')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TasksList(
                  tasks: highPriorityTasks,
                  onChanged: (bool? value, int index) async {
                    setState(() {
                      highPriorityTasks[index].isCompleted = value!;
                    });
                    final allTasks = SharedPreferencesManager().getString(
                      'tasks',
                    );
                    if (allTasks == null) return;
                    List<TaskModel> allTasksList =
                        (jsonDecode(allTasks) as List)
                            .map((e) => TaskModel.fromJson(e))
                            .toList();
                    final taskIndex = allTasksList.indexWhere(
                      (e) => e.id == highPriorityTasks[index].id,
                    );
                    allTasksList[taskIndex] = highPriorityTasks[index];
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
          ),
        ),
      ),
    );
  }
}

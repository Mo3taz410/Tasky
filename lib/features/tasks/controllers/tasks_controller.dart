import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../core/constants/storage_keys.dart';
import '../../../core/services/shared_preferences_manager.dart';
import '../../../models/task_model.dart';

class TasksController extends ChangeNotifier {
  bool isLoading = true;

  List<TaskModel> tasks = [];
  List<TaskModel> completedTasks = [];
  List<TaskModel> todoTasks = [];
  List<TaskModel> highPriorityTasks = [];

  void loadTasks() async {
    final String? getTasks = SharedPreferencesManager().getString(
      StorageKeys.tasks,
    );
    if (getTasks == null) return;
    final List<dynamic> decodedList = jsonDecode(getTasks);
    tasks = decodedList.map((e) => TaskModel.fromJson(e)).toList();
    completedTasks = tasks.where((element) => element.isCompleted).toList();
    todoTasks = tasks.where((element) => !element.isCompleted).toList();
    highPriorityTasks = tasks
        .where((element) => element.isHighPriority)
        .toList();
    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteTask(int id) async {
    tasks.removeWhere((task) => task.id == id);
    completedTasks = tasks.where((element) => element.isCompleted).toList();
    todoTasks = tasks.where((element) => !element.isCompleted).toList();
    highPriorityTasks = tasks
        .where((element) => element.isHighPriority)
        .toList();

    final updatedTasks = tasks.map((e) => e.toJson()).toList();
    await SharedPreferencesManager().setString(
      StorageKeys.tasks,
      jsonEncode(updatedTasks),
    );
    notifyListeners();
  }

  Future<void> toogleTodo(bool? value, int? index) async {
    if (index == null) return;
    todoTasks[index].isCompleted = value!;
    final taskIndex = tasks.indexWhere((e) => e.id == todoTasks[index].id);
    tasks[taskIndex] = todoTasks[index];
    await SharedPreferencesManager().setString(
      StorageKeys.tasks,
      jsonEncode(tasks),
    );
    loadTasks();
  }

  Future<void> toogleCompleted(bool? value, int? index) async {
    if (index == null) return;
    completedTasks[index].isCompleted = value!;
    final taskIndex = tasks.indexWhere((e) => e.id == completedTasks[index].id);
    tasks[taskIndex] = completedTasks[index];
    await SharedPreferencesManager().setString(
      StorageKeys.tasks,
      jsonEncode(tasks),
    );
    loadTasks();
  }

  Future<void> toogleHighPriority(bool? value, int? index) async {
    if (index == null) return;
    highPriorityTasks[index].isCompleted = value!;
    final taskIndex = tasks.indexWhere(
      (e) => e.id == highPriorityTasks[index].id,
    );
    tasks[taskIndex] = highPriorityTasks[index];
    await SharedPreferencesManager().setString(
      StorageKeys.tasks,
      jsonEncode(tasks),
    );
    loadTasks();
  }
}

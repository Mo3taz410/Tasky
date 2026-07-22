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
    _loadData();
    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteTask(int id) async {
    tasks.removeWhere((task) => task.id == id);
    _loadData();

    final updatedTasks = tasks.map((e) => e.toJson()).toList();
    await SharedPreferencesManager().setString(
      StorageKeys.tasks,
      jsonEncode(updatedTasks),
    );
    notifyListeners();
  }

  Future<void> toggleCompleted(bool? value, {required int id}) async {
    final index = tasks.indexWhere((element) => element.id == id);
    tasks[index].isCompleted = value!;
    _loadData();
    await SharedPreferencesManager().setString(
      StorageKeys.tasks,
      jsonEncode(tasks),
    );
    notifyListeners();
  }

  _loadData() {
    todoTasks = tasks.where((element) => !element.isCompleted).toList();
    completedTasks = tasks.where((element) => element.isCompleted).toList();
    highPriorityTasks = tasks
        .where((element) => element.isHighPriority)
        .toList();
  }
}

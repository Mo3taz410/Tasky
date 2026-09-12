import 'package:flutter/material.dart';
import 'package:tasky/core/services/file_storage_manager.dart';
import '../../../models/task_model.dart';

class TasksController extends ChangeNotifier {
  bool isLoading = true;

  List<TaskModel> tasks = [];
  List<TaskModel> completedTasks = [];
  List<TaskModel> todoTasks = [];
  List<TaskModel> highPriorityTasks = [];

  void loadTasks() async {
    // final String? getTasks = SharedPreferencesManager().getString(
    //   StorageKeys.tasks,
    // );
    // if (getTasks == null) return;
    final decodedList = await FileStorageManager().loadTasks();
    tasks = decodedList.map((e) => TaskModel.fromJson(e)).toList();
    _loadData();
    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteTask(int id) async {
    tasks.removeWhere((task) => task.id == id);
    _loadData();

    final updatedTasks = tasks.map((e) => e.toJson()).toList();
    await FileStorageManager().saveTasks(updatedTasks);
    notifyListeners();
  }

  Future<void> toggleCompleted(bool? value, {required int id}) async {
    final index = tasks.indexWhere((element) => element.id == id);
    tasks[index].isCompleted = value!;
    _loadData();
    await FileStorageManager().saveTasks(tasks);
    notifyListeners();
  }

  void _loadData() {
    todoTasks = tasks.where((element) => !element.isCompleted).toList();
    completedTasks = tasks.where((element) => element.isCompleted).toList();
    highPriorityTasks = tasks.where((element) => element.isHighPriority).toList();
  }
}

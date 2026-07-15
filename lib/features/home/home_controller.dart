import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import '../../core/constants/storage_keys.dart';
import '../../core/services/shared_preferences_manager.dart';

class HomeController with ChangeNotifier {
  late final String name;
  String? profilePicturePath;
  bool isLoading = true;
  List<TaskModel> tasks = [];
  int completedTasks = 0;

  void init() {
    loadUserInfo();
    loadTasks();
  }

  void loadUserInfo() async {
    profilePicturePath = SharedPreferencesManager().getString(
      StorageKeys.profilePicture,
    );
    name = SharedPreferencesManager().getString(StorageKeys.userName) ?? "";
    isLoading = false;
    notifyListeners();
  }

  void loadTasks() async {
    final String? getTasks = SharedPreferencesManager().getString(
      StorageKeys.tasks,
    );
    if (getTasks == null) return;
    final List<dynamic> decodedList = jsonDecode(getTasks);
    tasks = decodedList.map((e) => TaskModel.fromJson(e)).toList();
    completedTasks = tasks.where((element) => element.isCompleted).length;
    notifyListeners();
  }

  Future<void> isCompleted(bool? value, int index) async {
    tasks[index].isCompleted = value!;
    completedTasks = tasks.where((element) => element.isCompleted).length;

    final updatedTasks = tasks.map((e) => e.toJson()).toList();
    await SharedPreferencesManager().setString(
      StorageKeys.tasks,
      jsonEncode(updatedTasks),
    );
    notifyListeners();
  }

  Future<void> deleteTask(int id) async {
    tasks.removeWhere((task) => task.id == id);

    final updatedTasks = tasks.map((e) => e.toJson()).toList();
    await SharedPreferencesManager().setString(
      StorageKeys.tasks,
      jsonEncode(updatedTasks),
    );
    notifyListeners();
  }
}

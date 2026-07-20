import 'dart:convert';

import 'package:flutter/material.dart';

import '../../core/constants/storage_keys.dart';
import '../../core/services/shared_preferences_manager.dart';
import '../../models/task_model.dart';

class AddTaskController extends ChangeNotifier {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isHighPriority = true;

  Future<void> addTask(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final tasksJson = SharedPreferencesManager().getString(StorageKeys.tasks);
      List<dynamic> tasksList = [];
      if (tasksJson != null) {
        tasksList = jsonDecode(tasksJson);
      }
      TaskModel task = TaskModel(
        id: tasksList.length + 1,
        name: taskNameController.text,
        description: taskDescriptionController.text,
        isHighPriority: isHighPriority,
      );

      tasksList.add(task.toJson());
      final tasksEncode = jsonEncode(tasksList);
      await SharedPreferencesManager().setString(
        StorageKeys.tasks,
        tasksEncode,
      );
      if (!context.mounted) return;
      Navigator.of(context).pop(true);
    }
  }

  void toggle(bool value) {
    isHighPriority = value;
    notifyListeners();
  }
}

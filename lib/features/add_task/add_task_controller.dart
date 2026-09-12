import 'package:flutter/material.dart';
import 'package:tasky/core/services/file_storage_manager.dart';
import '../../models/task_model.dart';

class AddTaskController extends ChangeNotifier {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isHighPriority = true;

  Future<void> addTask(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      List<dynamic> tasksList = await FileStorageManager().loadTasks();

      TaskModel task = TaskModel(
        id: tasksList.length + 1,
        name: taskNameController.text,
        description: taskDescriptionController.text,
        isHighPriority: isHighPriority,
      );

      tasksList.add(task.toJson());

      await FileStorageManager().saveTasks(tasksList);

      if (!context.mounted) return;
      Navigator.of(context).pop(true);
    }
  }

  void toggle(bool value) {
    isHighPriority = value;
    notifyListeners();
  }
}

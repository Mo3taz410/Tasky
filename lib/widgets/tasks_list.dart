import 'package:flutter/material.dart';
import 'package:tasky/widgets/task_item.dart';

import '../models/task_model.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
    required this.tasks,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int) onChanged;
  final Function(int) onDelete;
  final Function() onEdit;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(bottom: 50),
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        return TaskItem(
          taskModel: tasks[index],
          onChanged: (value) {
            onChanged(value, index);
          },
          onDelete: (int id) {
            onDelete(id);
          },
          onEdit: () {
            onEdit();
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 8);
      },
    );
  }
}

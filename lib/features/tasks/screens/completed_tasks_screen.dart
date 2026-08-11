import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/features/tasks/controllers/tasks_controller.dart';
import '../../../core/components/tasks_list.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TasksController controller = context.read<TasksController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Completed Tasks', style: Theme.of(context).textTheme.labelLarge),
        SizedBox(height: AppSizes.h20),
        Expanded(
          child: Consumer<TasksController>(
            builder: (BuildContext context, TasksController tasksController, Widget? child) {
              return TasksList(
                tasks: tasksController.completedTasks,
                onChanged: (bool? value, int index) async {
                  await controller.toggleCompleted(value, id: tasksController.completedTasks[index].id); // testt
                },
                onDelete: (int id) {
                  controller.deleteTask(id);
                },
                onEdit: () {
                  controller.loadTasks();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

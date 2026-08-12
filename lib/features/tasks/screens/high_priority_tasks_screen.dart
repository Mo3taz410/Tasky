import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/components/tasks_list.dart';
import '../../../core/constants/app_sizes.dart';
import '../controllers/tasks_controller.dart';

class HighPriorityTasksScreen extends StatelessWidget {
  const HighPriorityTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TasksController controller = context.read<TasksController>();

    return Scaffold(
      appBar: AppBar(title: Text('High Priority Tasks')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.w16, vertical: AppSizes.h16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Consumer(
                  builder: (BuildContext context, TasksController tasksController, Widget? child) {
                    return TasksList(
                      tasks: tasksController.highPriorityTasks,
                      onChanged: (bool? value, int index) async {
                        await controller.toggleCompleted(
                          value,
                          id: tasksController.highPriorityTasks[index].id, //testt
                        );
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
          ),
        ),
      ),
    );
  }
}

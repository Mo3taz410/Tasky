import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/tasks/controllers/tasks_controller.dart';
import '../../../core/components/tasks_list.dart';

class ToDoTasksScreen extends StatelessWidget {
  const ToDoTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TasksController>(
      create: (_) {
        return TasksController()..loadTasks();
      },
      builder: (BuildContext context, _) {
        final TasksController controller = context.read<TasksController>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('To Do Tasks', style: Theme.of(context).textTheme.labelLarge),
            SizedBox(height: 20),
            Expanded(
              child: Consumer<TasksController>(
                builder:
                    (
                      BuildContext context,
                      TasksController tasksController,
                      Widget? child,
                    ) {
                      return TasksList(
                        tasks: tasksController.todoTasks,
                        onChanged: (bool? value, int index) async {
                          await controller.toogleTodo(value, index);
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
      },
    );
  }
}

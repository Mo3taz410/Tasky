import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/components/task_item.dart';
import '../../tasks/controllers/tasks_controller.dart';

class SliverTasksList extends StatelessWidget {
  const SliverTasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder:
          (BuildContext context, TasksController controller, Widget? child) {
            return controller.isLoading
                ? SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator(value: 20)),
                  )
                : controller.tasks.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'No Tasks Yet',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.only(bottom: 80),
                    sliver: SliverList.separated(
                      itemCount: controller.tasks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TaskItem(
                          taskModel: controller.tasks[index],
                          onChanged: (value) {
                            controller.toggleCompleted(
                              value,
                              id: controller.tasks[index].id,
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
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 8);
                      },
                    ),
                  );
          },
    );
  }
}

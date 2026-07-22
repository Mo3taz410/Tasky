import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../tasks/controllers/tasks_controller.dart';

class AchievedTasks extends StatelessWidget {
  const AchievedTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder: (BuildContext context, TasksController controller, Widget? child) {
        return Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Achieved Tasks',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${controller.completedTasks.length} Out of ${controller.tasks.length} Done',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: -pi / 2,
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: CircularProgressIndicator(
                        backgroundColor: Color(0xFF6D6D6D),
                        value: controller.tasks.isEmpty
                            ? 0
                            : controller.completedTasks.length /
                                  controller.tasks.length,
                        color: Color(0xFF15B86C),
                        strokeWidth: 4,
                      ),
                    ),
                  ),
                  Text(
                    controller.tasks.isEmpty
                        ? '0%'
                        : '${(controller.completedTasks.length / controller.tasks.length * 100).toStringAsFixed(0)}%',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/tasks/screens/high_priority_tasks_screen.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/custom_checkbox.dart';
import '../../../core/widgets/custom_svg_picture.dart';
import '../../tasks/controllers/tasks_controller.dart';

class HighPriorityTasks extends StatelessWidget {
  const HighPriorityTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder: (BuildContext context, TasksController controller, Widget? child) {
        final highPriorityTasks = controller.tasks.where((task) => task.isHighPriority).toList();
        return Container(
          padding: EdgeInsets.only(bottom: 8),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'High Priority Tasks',
                        style: TextStyle(color: Color(0xFF15B86C), fontSize: AppSizes.sp14),
                      ),
                    ),

                    ...highPriorityTasks.take(4).map((e) {
                      return Row(
                        children: [
                          CustomCheckbox(
                            value: e.isCompleted,
                            onChanged: (value) {
                              controller.toggleCompleted(value, id: e.id);
                            },
                          ),
                          Expanded(
                            child: Text(
                              e.name,
                              style: e.isCompleted
                                  ? Theme.of(context).textTheme.titleLarge
                                  : Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: () async {
                    await Navigator.push(context, MaterialPageRoute(builder: (context) => HighPriorityTasksScreen()));
                    controller.loadTasks();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    width: AppSizes.w40,
                    height: AppSizes.h40,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: ThemeController.isDarkMode() ? Color(0xFF6E6E6E) : Color(0xFFD1DAD6),
                        width: 1,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: CustomSvgPicture(path: 'assets/icons/arrow_up_right.svg'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

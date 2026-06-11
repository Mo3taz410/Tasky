import 'package:flutter/material.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/tasks/high_priority_tasks_screen.dart';

import '../../../core/widgets/custom_checkbox.dart';
import '../../../core/widgets/custom_svg_picture.dart';
import '../../../models/task_model.dart';

class HighPriorityTasks extends StatelessWidget {
  const HighPriorityTasks({
    super.key,
    required this.highPriorityTasks,
    required this.onChanged,
    required this.refresh,
  });

  final List<TaskModel> highPriorityTasks;
  final Function(bool?, int) onChanged;
  final Function() refresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8), //TODO: TEST
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
                    style: TextStyle(color: Color(0xFF15B86C), fontSize: 14),
                  ),
                ),

                ...highPriorityTasks.take(4).map((e) {
                  return Row(
                    children: [
                      CustomCheckbox(
                        value: e.isCompleted,
                        onChanged: (value) {
                          final index = highPriorityTasks.indexOf(e);
                          onChanged(value, index);
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
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HighPriorityTasksScreen(),
                  ),
                );
                refresh();
              },
              child: Container(
                padding: EdgeInsets.all(8),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: ThemeController.isDarkMode()
                        ? Color(0xFF6E6E6E)
                        : Color(0xFFD1DAD6),
                    width: 1,
                  ),
                  shape: BoxShape.circle,
                ),
                child: CustomSvgPicture(
                  path: 'assets/icons/arrow_up_right.svg',
                ),
                // SvgPicture.asset(
                //   'assets/icons/arrow_up_right.svg',
                //   width: 10,
                //   height: 10,
                //   colorFilter: ColorFilter.mode(
                //     ThemeController.isDarkMode() ? Color(0xFFC6C6C6) : Color(0xFF3A4640),
                //     BlendMode.srcIn,
                //   ),
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import '../constants/storage_keys.dart';
import '../enums/task_item_actions.dart';
import '../services/shared_preferences_manager.dart';
import '../widgets/custom_checkbox.dart';
import '../widgets/custom_text_form_field.dart';
import '../../models/task_model.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.taskModel,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });

  final TaskModel taskModel;
  final Function(bool?) onChanged;
  final Function(int) onDelete;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: ThemeController.isDarkMode()
            ? null
            : Border.all(color: Color(0xFFD1DAD6)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomCheckbox(value: taskModel.isCompleted, onChanged: onChanged),
          Expanded(
            child: taskModel.description == ''
                ? Text(
                    taskModel.name,
                    style: taskModel.isCompleted
                        ? Theme.of(context).textTheme.titleLarge
                        : Theme.of(context).textTheme.titleMedium,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        taskModel.name,
                        style: taskModel.isCompleted
                            ? Theme.of(context).textTheme.titleLarge
                            : Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        taskModel.description,
                        style: TextStyle(
                          color: Color(0xFFC6C6C6),
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
          ),
          PopupMenuButton<TaskItemActions>(
            icon: Icon(
              Icons.more_vert,
              color: ThemeController.isDarkMode()
                  ? (taskModel.isCompleted ? Color(0xFFA0A0A0) : null)
                  : taskModel.isCompleted
                  ? Color(0xFF6A6A6A)
                  : null,
            ),
            itemBuilder: (context) => TaskItemActions.values.map((action) {
              return PopupMenuItem<TaskItemActions>(
                value: action,
                child: Text(action.name),
              );
            }).toList(),
            onSelected: (value) async {
              switch (value) {
                case TaskItemActions.edit:
                  final result = await _showEditDialog(
                    context,
                    taskModel: taskModel,
                  );
                  if (result == true) {
                    onEdit();
                  }
                  break;
                case TaskItemActions.delete:
                  await _showDeleteDialog(context);
                  break;
              }
            },
          ),
        ],
      ),
    );
  }

  _showDeleteDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Task'),
          content: Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onDelete(taskModel.id);
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showEditDialog(context, {required TaskModel taskModel}) {
    final TextEditingController taskNameController = TextEditingController(
      text: taskModel.name,
    );
    final TextEditingController taskDescriptionController =
        TextEditingController(text: taskModel.description);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    bool isHighPriority = taskModel.isHighPriority;

    return showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            CustomTextFormField(
                              controller: taskNameController,
                              hintText: 'Finish UI design for login screen',
                              validator: (String? value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter a task name.';
                                }
                                return null;
                              },
                              title: 'Task Name',
                            ),
                            SizedBox(height: 20),
                            SizedBox(height: 8),
                            CustomTextFormField(
                              title: 'Task Description (Optional)',
                              controller: taskDescriptionController,
                              hintText:
                                  'Finish onboarding UI and hand off to devs by Thursday.',
                              maxLines: 5,
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'High Priority',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Switch(
                                  value: isHighPriority,
                                  onChanged: (bool value) {
                                    setState(() {
                                      isHighPriority = value;
                                    });
                                  },
                                  activeTrackColor: Color(0xFF15B86C),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final tasksJson = SharedPreferencesManager()
                                .getString(StorageKeys.tasks);
                            List<dynamic> tasksList = [];
                            if (tasksJson != null) {
                              tasksList = jsonDecode(tasksJson);
                            }
                            TaskModel newTaskModel = TaskModel(
                              id: taskModel.id,
                              name: taskNameController.text,
                              description: taskDescriptionController.text,
                              isHighPriority: isHighPriority,
                              isCompleted: taskModel.isCompleted,
                            );
                            final currentTask = tasksList.firstWhere(
                              (element) => element['id'] == taskModel.id,
                            );
                            final index = tasksList.indexOf(currentTask);
                            tasksList[index] = newTaskModel;

                            final tasksEncode = jsonEncode(tasksList);
                            await SharedPreferencesManager().setString(
                              StorageKeys.tasks,
                              tasksEncode,
                            );
                            if (!context.mounted) return;
                            Navigator.of(context).pop(true);
                          }
                        },
                        icon: Icon(Icons.edit),
                        label: Text('Edit Task'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

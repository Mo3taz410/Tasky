import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';

import '../../core/services/shared_preferences_manager.dart';
import '../../core/widgets/custom_text_form_field.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  /// TODO : DISPOSE CONTROLLERS
  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isHighPriority = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Task')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            key: _formKey,
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
                              style: Theme.of(context).textTheme.titleMedium,
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
                      if (_formKey.currentState!.validate()) {
                        final tasksJson = SharedPreferencesManager().getString(
                          'tasks',
                        );
                        List<dynamic> tasksList = [];
                        if (tasksJson != null) {
                          tasksList = jsonDecode(tasksJson);
                        }
                        TaskModel task = TaskModel(
                          id: tasksList.length + 1,
                          name: taskNameController.text,
                          description: taskDescriptionController.text,
                          isHighPriority: isHighPriority,
                        );

                        tasksList.add(task.toJson());
                        final tasksEncode = jsonEncode(tasksList);
                        await SharedPreferencesManager().setString(
                          'tasks',
                          tasksEncode,
                        );
                        if (!context.mounted) return;
                        Navigator.of(context).pop(true);
                      }
                    },
                    icon: Icon(Icons.add),
                    label: Text('Add Task'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

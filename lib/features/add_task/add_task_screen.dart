import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/widgets/custom_text_form_field.dart';
import 'add_task_controller.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext _) {
    return ChangeNotifierProvider<AddTaskController>(
      create: (_) {
        return AddTaskController();
      },
      builder: (BuildContext context, _) {
        final AddTaskController controller = context.read<AddTaskController>();
        return Scaffold(
          appBar: AppBar(title: Text('New Task')),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: AppSizes.h8),
                            CustomTextFormField(
                              controller: controller.taskNameController,
                              hintText: 'Finish UI design for login screen',
                              validator: (String? value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter a task name.';
                                }
                                return null;
                              },
                              title: 'Task Name',
                            ),
                            SizedBox(height: AppSizes.h20),
                            SizedBox(height: AppSizes.h8),
                            CustomTextFormField(
                              title: 'Task Description (Optional)',
                              controller: controller.taskDescriptionController,
                              hintText: 'Finish onboarding UI and hand off to devs by Thursday.',
                              maxLines: 5,
                            ),
                            SizedBox(height: AppSizes.h20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('High Priority', style: Theme.of(context).textTheme.titleMedium),
                                Consumer<AddTaskController>(
                                  builder: (BuildContext context, AddTaskController addTaskController, Widget? child) {
                                    return Switch(
                                      value: addTaskController.isHighPriority,
                                      onChanged: (bool value) {
                                        controller.toggle(value);
                                      },
                                      activeTrackColor: Color(0xFF15B86C),
                                    );
                                  },
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
                          await context.read<AddTaskController>().addTask(context);
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
      },
    );
  }
}

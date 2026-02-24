import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/providers/task_provider.dart';
import 'package:frontend_hackathon_mobile/shared/widgets/authenticated_app_bar.dart';
import 'package:frontend_hackathon_mobile/shared/widgets/floating_add_task_buttom.dart';
import 'package:frontend_hackathon_mobile/views/task_list/task_card_widget.dart';
import 'package:provider/provider.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<TaskProvider>().allTasks;

    return Scaffold(
      appBar: AuthenticatedAppBar(),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 96),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskCard(task: tasks[index]);
        },
      ),
      floatingActionButton: FloatingAddTaskButtom(),
    );
  }
}

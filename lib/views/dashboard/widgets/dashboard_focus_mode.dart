import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/providers/task_provider.dart';
import 'package:frontend_hackathon_mobile/shared/widgets/task_card_widget.dart';
import 'package:provider/provider.dart';

class FocusModeDashboard extends StatelessWidget {
  const FocusModeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();

    final tasksWithDueDate = taskProvider.inProgressTasks
        .where((task) => task.dueDate != null)
        .toList();

    final sortedTasks = taskProvider.inProgressTasks
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

    final inProgressTasks = tasksWithDueDate.isNotEmpty
        ? tasksWithDueDate
        : sortedTasks.take(2).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 32, bottom: 24),
          child: Text(
            'Modo Foco',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 96),
            itemCount: inProgressTasks.length,
            itemBuilder: (context, index) =>
                TaskCard(task: inProgressTasks[index]),
          ),
        ),
      ],
    );
  }
}

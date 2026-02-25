import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/models/task_model.dart';
import 'package:frontend_hackathon_mobile/providers/task_provider.dart';
import 'package:provider/provider.dart';

class ActionButtons extends StatelessWidget {
  final Task task;

  const ActionButtons({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    if (task.status == TaskStatus.completed) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (task.status == TaskStatus.pending)
          FilledButton.icon(
            onPressed: () async {
              await context.read<TaskProvider>().startPendingTask(task.id);
              if (context.mounted) Navigator.of(context).pop();
            },
            icon: const Icon(Icons.play_arrow_outlined),
            label: const Text('Iniciar tarefa'),
          ),
        if (task.status == TaskStatus.inProgress) ...[
          FilledButton.icon(
            onPressed: () async {
              await context.read<TaskProvider>().updateTaskStatus(
                task.id,
                TaskStatus.completed,
              );
              if (context.mounted) Navigator.of(context).pop();
            },
            icon: const Icon(Icons.check_outlined),
            label: const Text('Marcar como concluída'),
          ),
        ],
      ],
    );
  }
}

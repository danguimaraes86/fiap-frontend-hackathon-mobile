import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/providers/task_provider.dart';
import 'package:frontend_hackathon_mobile/providers/user_preferences_provider.dart';
import 'package:frontend_hackathon_mobile/shared/widgets/authenticated_app_bar.dart';
import 'package:frontend_hackathon_mobile/shared/widgets/floating_add_task_buttom.dart';
import 'package:frontend_hackathon_mobile/shared/widgets/task_card_widget.dart';
import 'package:provider/provider.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  Widget _buildSectionHeader(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Divider(color: Theme.of(context).colorScheme.onSurface),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final userPreferencesProvider = context.watch<UserPreferencesProvider>();

    final inProgressTasks = taskProvider.inProgressTasks;
    final pendingTasks = taskProvider.pendingTasks;
    final completedTasks = taskProvider.completedTasks;

    final showPendingTasks =
        userPreferencesProvider.preferences.showPendingTasks;
    final showCompletedTasks =
        userPreferencesProvider.preferences.showCompletedTasks;

    final List<Widget> taskList = [
      if (inProgressTasks.isNotEmpty) ...[
        _buildSectionHeader(
          context,
          'Em andamento (${inProgressTasks.length})',
        ),
        ...inProgressTasks.map((task) => TaskCard(task: task)),
      ],
      if (showPendingTasks && pendingTasks.isNotEmpty) ...[
        _buildSectionHeader(context, 'Pendentes (${pendingTasks.length})'),
        ...pendingTasks.map((task) => TaskCard(task: task)),
      ],
      if (showCompletedTasks && completedTasks.isNotEmpty) ...[
        _buildSectionHeader(context, 'Concluídas (${completedTasks.length})'),
        ...completedTasks.map((task) => TaskCard(task: task)),
      ],
    ];

    return Scaffold(
      appBar: AuthenticatedAppBar(),
      body: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 96),
        children: taskList,
      ),
      floatingActionButton: FloatingAddTaskButtom(),
    );
  }
}

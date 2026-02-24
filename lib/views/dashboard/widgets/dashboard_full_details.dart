import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/configs/routes.dart';
import 'package:frontend_hackathon_mobile/models/task_model.dart';
import 'package:frontend_hackathon_mobile/providers/authentication_provider.dart';
import 'package:frontend_hackathon_mobile/providers/task_provider.dart';
import 'package:provider/provider.dart';

class DetailedDashboardCard extends StatelessWidget {
  const DetailedDashboardCard({super.key});

  String _getWelcomeMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Bom dia!';
    } else if (hour < 18) {
      return 'Boa tarde!';
    } else {
      return 'Boa noite!';
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthenticationProvider>().user;
    final username = user?.name ?? 'Usuário';

    final inProgressTasks = context.watch<TaskProvider>().inProgressTasks;
    final pendingTasks = context.watch<TaskProvider>().pendingTasks;

    final List<Map<String, dynamic>> taskStatuses = [
      {
        'status': TaskStatus.inProgress,
        'itens': inProgressTasks,
        'count': inProgressTasks.length,
      },
      {
        'status': TaskStatus.pending,
        'itens': pendingTasks,
        'count': pendingTasks.length,
      },
    ];

    final int taskCount = [
      inProgressTasks,
      pendingTasks,
    ].reduce((a, b) => [...a, ...b]).length;

    final bool hastasks = taskCount > 0;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Card Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bem-vindo, $username',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getWelcomeMessage(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
        
              // Card Content
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 40.0,
                  horizontal: 16.0,
                ),
                child: Center(
                  child: hastasks
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 12,
                          children: taskStatuses
                              .where((s) => (s['count'] as int) > 0)
                              .map((statusMap) {
                                final status = statusMap['status'] as TaskStatus;
                                final count = statusMap['count'] as int;
        
                                return Badge(
                                  label: Text(
                                    count.toString(),
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimary,
                                    ),
                                  ),
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.primary,
                                  child: Chip(
                                    avatar: Icon(status.icon, size: 20),
                                    label: Text(status.label),
                                  ),
                                );
                              })
                              .toList(),
                        )
                      : Icon(
                          Icons.self_improvement,
                          size: 80,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                ),
              ),
        
              // Card Actions
              if (hastasks)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.taskList);
                        },
                        icon: const Icon(Icons.task),
                        label: const Text('Ver Tarefas'),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

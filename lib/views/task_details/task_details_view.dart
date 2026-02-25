import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/models/task_model.dart';
import 'package:frontend_hackathon_mobile/providers/task_provider.dart';
import 'package:frontend_hackathon_mobile/shared/widgets/shared_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TaskDetailsView extends StatelessWidget {
  const TaskDetailsView({super.key});

  static Route<void> route(Task task) {
    return MaterialPageRoute(
      builder: (_) => const TaskDetailsView(),
      settings: RouteSettings(arguments: task),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '--';
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final task = ModalRoute.of(context)!.settings.arguments as Task;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: SharedAppBar(
        title: 'Detalhes da Tarefa',
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Excluir tarefa',
            onPressed: () => _confirmDelete(context, task),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _StatusBadge(status: task.status),
            const SizedBox(height: 16),
            Text(
              task.title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _SectionCard(
              children: [
                _DetailRow(
                  icon: Icons.description_outlined,
                  label: 'Descrição',
                  value: task.description?.isNotEmpty == true
                      ? task.description!
                      : '--',
                ),
              ],
            ),
            const SizedBox(height: 16),
            _SectionCard(
              children: [
                _DetailRow(
                  icon: Icons.calendar_today_outlined,
                  label: 'Prazo',
                  value: _formatDate(task.dueDate),
                  valueColor:
                      task.dueDate != null &&
                          task.dueDate!.isBefore(DateTime.now()) &&
                          task.status != TaskStatus.completed
                      ? colorScheme.error
                      : null,
                ),
                const Divider(),
                _DetailRow(
                  icon: Icons.add_circle_outline,
                  label: 'Criada em',
                  value: _formatDate(task.createdAt),
                ),
                const Divider(),
                _DetailRow(
                  icon: Icons.update_outlined,
                  label: 'Atualizada em',
                  value: _formatDate(task.updatedAt),
                ),
                const Divider(),
                _DetailRow(
                  icon: Icons.check_circle_outline,
                  label: 'Concluída em',
                  value: _formatDate(task.completedAt),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _ActionButtons(task: task),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, Task task) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir tarefa'),
        content: const Text('Tem certeza que deseja excluir esta tarefa?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await context.read<TaskProvider>().deleteTask(task.id);
      if (context.mounted) Navigator.of(context).pop();
    }
  }
}

class _StatusBadge extends StatelessWidget {
  final TaskStatus status;

  const _StatusBadge({required this.status});

  Color _resolveColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return switch (status.color) {
      'primary' => colorScheme.primary,
      'secondary' => colorScheme.secondary,
      'tertiary' => colorScheme.tertiary,
      _ => colorScheme.primary,
    };
  }

  @override
  Widget build(BuildContext context) {
    final color = _resolveColor(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(status.icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            status.label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final List<Widget> children;

  const _SectionCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: valueColor ?? theme.colorScheme.onSurface,
                    fontStyle: value == '--' ? FontStyle.italic : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final Task task;

  const _ActionButtons({required this.task});

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

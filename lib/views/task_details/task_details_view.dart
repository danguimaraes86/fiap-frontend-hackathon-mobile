import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/models/task_model.dart';
import 'package:frontend_hackathon_mobile/providers/task_provider.dart';
import 'package:frontend_hackathon_mobile/shared/widgets/shared_app_bar.dart';
import 'package:frontend_hackathon_mobile/views/task_details/widgets/task_action_buttons.dart';
import 'package:frontend_hackathon_mobile/views/task_details/widgets/task_detail_row.dart';
import 'package:frontend_hackathon_mobile/views/task_details/widgets/task_section_card.dart';
import 'package:frontend_hackathon_mobile/views/task_details/widgets/task_status_badge.dart';
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
            Text(
              task.title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            StatusBadge(status: task.status),
            const SizedBox(height: 24),
            SectionCard(
              children: [
                DetailRow(
                  icon: Icons.description_outlined,
                  label: 'Descrição',
                  value: task.description?.isNotEmpty == true
                      ? task.description!
                      : '--',
                ),
              ],
            ),
            const SizedBox(height: 16),
            SectionCard(
              children: [
                DetailRow(
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
                DetailRow(
                  icon: Icons.add_circle_outline,
                  label: 'Criada em',
                  value: _formatDate(task.createdAt),
                ),
                const Divider(),
                DetailRow(
                  icon: Icons.update_outlined,
                  label: 'Atualizada em',
                  value: _formatDate(task.updatedAt),
                ),
                const Divider(),
                DetailRow(
                  icon: Icons.check_circle_outline,
                  label: 'Concluída em',
                  value: _formatDate(task.completedAt),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ActionButtons(task: task),
          ],
        ),
      ),
    );
  }
}

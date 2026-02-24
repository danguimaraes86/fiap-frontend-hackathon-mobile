import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/configs/custom_theme.dart';
import 'package:frontend_hackathon_mobile/models/task_model.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outlineVariant, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TaskCardHeader(task: task),
            const SizedBox(height: 8),
            _TaskCardBody(task: task),
          ],
        ),
      ),
    );
  }
}

enum _TaskMenuOption { complete, start, edit, delete, details }

class _TaskCardHeader extends StatelessWidget {
  final Task task;

  const _TaskCardHeader({required this.task});

  void _handleMenuSelection(_TaskMenuOption option) {}

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            task.title,
            style: Theme.of(context).textTheme.headlineSmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        PopupMenuButton<_TaskMenuOption>(
          icon: const Icon(Icons.more_vert),
          onSelected: _handleMenuSelection,
          itemBuilder: (context) => [
            if (task.status.value == TaskStatus.inProgress.value)
              const PopupMenuItem(
                value: _TaskMenuOption.complete,
                child: Row(
                  children: [
                    Icon(Icons.check_box),
                    SizedBox(width: 8),
                    Text('Concluir Tarefa'),
                  ],
                ),
              ),
            if (task.status.value == TaskStatus.pending.value)
              const PopupMenuItem(
                value: _TaskMenuOption.start,
                child: Row(
                  children: [
                    Icon(Icons.play_arrow),
                    SizedBox(width: 8),
                    Text('Iniciar Tarefa'),
                  ],
                ),
              ),
            const PopupMenuItem(
              value: _TaskMenuOption.edit,
              child: Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: 8),
                  Text('Editar'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: _TaskMenuOption.delete,
              child: Row(
                children: [
                  Icon(Icons.delete),
                  SizedBox(width: 8),
                  Text('Remover'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: _TaskMenuOption.details,
              child: Row(
                children: [
                  Icon(Icons.description),
                  SizedBox(width: 8),
                  Text('Ver Dados Completos'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TaskCardBody extends StatelessWidget {
  final Task task;

  const _TaskCardBody({required this.task});

  @override
  Widget build(BuildContext context) {
    final lightColorScheme = CustomTheme(
      Theme.of(context).textTheme,
    ).light().colorScheme;

    final colors = {
      'primary': (
        fg: lightColorScheme.onSurface,
        bg: lightColorScheme.onPrimaryContainer,
      ),
      'secondary': (
        fg: lightColorScheme.onSurface,
        bg: lightColorScheme.onSecondaryContainer,
      ),
      'tertiary': (
        fg: lightColorScheme.onSurface,
        bg: lightColorScheme.onTertiaryContainer,
      ),
    };

    final chipColors = colors[task.status.color] ?? colors['primary']!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (task.description != null) ...[
                Row(
                  children: [
                    Icon(Icons.description, size: 14),
                    Text(
                      task.description!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
              if (task.dueDate != null) _DueDateText(dueDate: task.dueDate!),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Chip(
          label: Text(task.status.label),
          backgroundColor: chipColors.bg,
          labelStyle: TextStyle(color: chipColors.fg),
        ),
      ],
    );
  }
}

class _DueDateText extends StatelessWidget {
  final DateTime dueDate;

  const _DueDateText({required this.dueDate});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final formatted = DateFormat.yMd(locale).format(dueDate);

    return Row(
      children: [
        const Icon(Icons.calendar_today, size: 14),
        const SizedBox(width: 4),
        Text(formatted, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

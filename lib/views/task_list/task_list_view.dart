import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/models/task_model.dart';
import 'package:frontend_hackathon_mobile/providers/task_provider.dart';
import 'package:frontend_hackathon_mobile/providers/user_preferences_provider.dart';
import 'package:frontend_hackathon_mobile/shared/widgets/floating_add_task_buttom.dart';
import 'package:frontend_hackathon_mobile/shared/widgets/shared_app_bar.dart';
import 'package:frontend_hackathon_mobile/shared/widgets/task_card_widget.dart';
import 'package:frontend_hackathon_mobile/views/task_list/widgets/task_filter_widget.dart';
import 'package:provider/provider.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  String _titleFilter = '';
  TaskStatus? _statusFilter;

  void _clearFilters() {
    setState(() {
      _titleFilter = '';
      _statusFilter = null;
    });
  }

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

  List<dynamic> _applyFilters(List<dynamic> tasks) {
    return tasks.where((task) {
      final matchesTitle =
          _titleFilter.isEmpty ||
          task.title.toLowerCase().contains(_titleFilter.toLowerCase());
      final matchesStatus =
          _statusFilter == null || task.status == _statusFilter;
      return matchesTitle && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final userPreferencesProvider = context.watch<UserPreferencesProvider>();

    final showPendingTasks =
        userPreferencesProvider.preferences.showPendingTasks;
    final showCompletedTasks =
        userPreferencesProvider.preferences.showCompletedTasks;

    final inProgressTasks = _applyFilters(taskProvider.inProgressTasks);
    final pendingTasks = _applyFilters(taskProvider.pendingTasks);
    final completedTasks = _applyFilters(taskProvider.completedTasks);

    final List<Widget> taskList = [
      TaskFilterWidget(
        titleFilter: _titleFilter,
        statusFilter: _statusFilter,
        onTitleChanged: (value) => setState(() => _titleFilter = value),
        onStatusChanged: (value) => setState(() => _statusFilter = value),
        onClearFilters: _clearFilters,
      ),
      if (_statusFilter == null || _statusFilter == TaskStatus.inProgress)
        if (inProgressTasks.isNotEmpty) ...[
          _buildSectionHeader(
            context,
            'Em andamento (${inProgressTasks.length})',
          ),
          ...inProgressTasks.map((task) => TaskCard(task: task)),
        ],
      if (showPendingTasks &&
          (_statusFilter == null || _statusFilter == TaskStatus.pending))
        if (pendingTasks.isNotEmpty) ...[
          _buildSectionHeader(context, 'Pendentes (${pendingTasks.length})'),
          ...pendingTasks.map((task) => TaskCard(task: task)),
        ],
      if (showCompletedTasks &&
          (_statusFilter == null || _statusFilter == TaskStatus.completed))
        if (completedTasks.isNotEmpty) ...[
          _buildSectionHeader(context, 'Concluídas (${completedTasks.length})'),
          ...completedTasks.map((task) => TaskCard(task: task)),
        ],
    ];

    return Scaffold(
      appBar: SharedAppBar(title: 'Lista de Tarefas'),
      body: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 96),
        children: taskList,
      ),
      floatingActionButton: FloatingAddTaskButtom(),
    );
  }
}

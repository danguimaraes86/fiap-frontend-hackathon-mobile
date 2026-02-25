import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/models/task_model.dart';

class TaskFilterWidget extends StatefulWidget {
  final String titleFilter;
  final TaskStatus? statusFilter;
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<TaskStatus?> onStatusChanged;
  final VoidCallback onClearFilters;

  const TaskFilterWidget({
    super.key,
    required this.titleFilter,
    required this.statusFilter,
    required this.onTitleChanged,
    required this.onStatusChanged,
    required this.onClearFilters,
  });

  @override
  State<TaskFilterWidget> createState() => _TaskFilterWidgetState();
}

class _TaskFilterWidgetState extends State<TaskFilterWidget> {
  late final TextEditingController _titleController;

  static const List<({TaskStatus? value, String label})> _statusList = [
    (value: null, label: 'Todos'),
    (value: TaskStatus.inProgress, label: 'Em andamento'),
    (value: TaskStatus.pending, label: 'Pendente'),
    (value: TaskStatus.completed, label: 'Concluída'),
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.titleFilter);
  }

  @override
  void didUpdateWidget(covariant TaskFilterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.titleFilter != _titleController.text) {
      _titleController.text = widget.titleFilter;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: const Icon(Icons.filter_list),
          title: const Text('Filtros'),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            labelText: 'Título',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          onChanged: widget.onTitleChanged,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<TaskStatus?>(
                          initialValue: widget.statusFilter,
                          decoration: const InputDecoration(
                            labelText: 'Status da Tarefa',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          items: _statusList
                              .map(
                                (s) => DropdownMenuItem(
                                  value: s.value,
                                  child: Text(s.label),
                                ),
                              )
                              .toList(),
                          onChanged: widget.onStatusChanged,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        _titleController.clear();
                        widget.onClearFilters();
                      },
                      child: const Text('Limpar'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
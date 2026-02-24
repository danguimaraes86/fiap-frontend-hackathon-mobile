import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/models/task_model.dart';
import 'package:frontend_hackathon_mobile/providers/task_provider.dart';
import 'package:frontend_hackathon_mobile/shared/utils/form_validators.dart';
import 'package:frontend_hackathon_mobile/shared/widgets/custom_input_text.dart';
import 'package:provider/provider.dart';

class TaskFormView extends StatefulWidget {
  final Task? task;

  const TaskFormView({super.key, this.task});

  @override
  State<TaskFormView> createState() => _TaskFormViewState();
}

class _TaskFormViewState extends State<TaskFormView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  TaskStatus _selectedStatus = TaskStatus.pending;
  DateTime? _dueDate;

  bool get _isEditing => widget.task != null;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description ?? '';
      _selectedStatus = widget.task!.status;
      _dueDate = widget.task!.dueDate;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDueDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
      helpText: 'Selecione a data de entrega',
    );
    if (picked != null) {
      setState(() => _dueDate = picked);
    }
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final now = DateTime.now();
      final task = Task(
        id: widget.task?.id ?? '',
        userId: widget.task?.userId ?? '',
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        status: _selectedStatus,
        dueDate: _dueDate,
        createdAt: widget.task?.createdAt ?? now,
        updatedAt: now,
        completedAt: _selectedStatus == TaskStatus.completed
            ? (widget.task?.completedAt ?? now)
            : null,
      );

      final provider = context.read<TaskProvider>();

      if (_isEditing) {
        await provider.updateTask(widget.task!.id, task);
      } else {
        await provider.addTask(task);
      }

      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro ao salvar tarefa: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Tarefa' : 'Nova Tarefa'),
        centerTitle: true,
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Título
              CustomInputTextWidget(
                controller: _titleController,
                labelText: 'Título',
                hintText: 'Digite o título da tarefa',

                validatorList: [(v) => validateRequiredField(v)],
              ),
              const SizedBox(height: 16),

              // Descrição
              CustomInputTextWidget(
                controller: _descriptionController,
                labelText: 'Descrição',
                hintText: 'Descreva a tarefa (opcional)',
              ),
              const SizedBox(height: 16),

              // Status e Data de Entrega
              Column(
                children: [
                  // Status
                  DropdownButtonFormField<TaskStatus>(
                    initialValue: _selectedStatus,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                      prefixIcon: Icon(Icons.flag_outlined),
                      border: OutlineInputBorder(),
                    ),
                    items: TaskStatus.values
                        .map(
                          (status) => DropdownMenuItem(
                            value: status,
                            child: Text(status.label),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedStatus = value);
                      }
                    },
                  ),

                  const SizedBox(height: 16),

                  // Data de Entrega
                  TextFormField(
                    readOnly: true,
                    onTap: _pickDueDate,
                    decoration: InputDecoration(
                      labelText: 'Data de Entrega',
                      hintText: 'DD/MM/AAAA',
                      prefixIcon: const Icon(Icons.calendar_today),
                      suffixIcon: _dueDate != null
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () => setState(() => _dueDate = null),
                            )
                          : null,
                      border: const OutlineInputBorder(),
                    ),
                    controller: TextEditingController(
                      text: _dueDate != null
                          ? '${_dueDate!.day.toString().padLeft(2, '0')}/${_dueDate!.month.toString().padLeft(2, '0')}/${_dueDate!.year}'
                          : '',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Botões
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: _isLoading
                        ? null
                        : () => Navigator.of(context).pop(),
                    child: const Text('Cancelar'),
                  ),
                  const SizedBox(width: 12),
                  FilledButton.icon(
                    onPressed: _isLoading ? null : _onSubmit,
                    icon: _isLoading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.save),
                    label: const Text('Salvar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

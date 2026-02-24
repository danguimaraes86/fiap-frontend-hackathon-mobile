import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/configs/custom_theme.dart';
import 'package:provider/provider.dart';

import '../../models/user_preferences_model.dart';
import '../../providers/user_preferences_provider.dart';

class UserPreferencesFormView extends StatefulWidget {
  const UserPreferencesFormView({super.key});

  @override
  State<UserPreferencesFormView> createState() =>
      _UserPreferencesFormViewState();
}

class _UserPreferencesFormViewState extends State<UserPreferencesFormView> {
  late ThemeType _theme;
  late bool _focusMode;
  late bool _showCompletedTasks;
  late bool _showPendingTasks;

  @override
  void initState() {
    super.initState();
    _loadFromProvider();
  }

  void _loadFromProvider() {
    final preferences = context.read<UserPreferencesProvider>().preferences;
    _theme = preferences.theme;
    _focusMode = preferences.focusMode;
    _showCompletedTasks = preferences.showCompletedTasks;
    _showPendingTasks = preferences.showPendingTasks;
  }

  void _handleFocusModeChange(bool value) {
    setState(() {
      _focusMode = value;
      if (value) {
        _showCompletedTasks = false;
        _showPendingTasks = false;
      }
    });
  }

  void _handleFilterChange(bool value) {
    if (value) {
      setState(() {
        _focusMode = false;
      });
    }
  }

  Future<void> _onSubmit() async {
    final provider = context.read<UserPreferencesProvider>();
    final updated = provider.preferences.copyWith(
      theme: _theme,
      focusMode: _focusMode,
      showCompletedTasks: _showCompletedTasks,
      showPendingTasks: _showPendingTasks,
    );
    await provider.updatePreferences(updated);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final lightTheme = CustomTheme(
      Theme.of(context).textTheme,
    ).light().colorScheme;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferências'),
        backgroundColor: lightTheme.primaryContainer,
        foregroundColor: lightTheme.surface,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: lightTheme.surface,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tema
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Tema', style: Theme.of(context).textTheme.titleMedium),
                RadioGroup<ThemeType>(
                  groupValue: _theme,
                  onChanged: (value) {
                    if (value != null) setState(() => _theme = value);
                  },
                  child: Wrap(
                    spacing: 4,
                    children: ThemeType.values.map((theme) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio<ThemeType>(value: theme),
                          Text(theme.label),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),

            const Divider(),

            // Modo Foco
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Modo Foco',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Switch(value: _focusMode, onChanged: _handleFocusModeChange),
              ],
            ),

            const Divider(),

            // Filtros
            Text('Filtros', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Mostrar tarefas pendentes'),
                Switch(
                  value: _showPendingTasks,
                  onChanged: (value) {
                    setState(() => _showPendingTasks = value);
                    _handleFilterChange(value);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Mostrar tarefas concluídas'),
                Switch(
                  value: _showCompletedTasks,
                  onChanged: (value) {
                    setState(() => _showCompletedTasks = value);
                    _handleFilterChange(value);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer<UserPreferencesProvider>(
            builder: (context, provider, _) {
              return FilledButton.icon(
                onPressed: provider.isLoading ? null : _onSubmit,
                icon: const Icon(Icons.save),
                label: const Text('Salvar'),
              );
            },
          ),
        ),
      ),
    );
  }
}

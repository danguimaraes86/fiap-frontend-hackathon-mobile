import 'package:flutter/material.dart';

import '../models/user_preferences_model.dart';
import '../services/user_preferences_service.dart';

class UserPreferencesProvider extends ChangeNotifier {
  late final UserPreferencesService _service;

  UserPreferencesProvider() {
    _service = UserPreferencesService();
  }

  UserPreferencesProvider.withService(UserPreferencesService service) {
    _service = service;
  }

  UserPreferencesModel _preferences = UserPreferencesModel.defaultPreferences;
  bool _isLoading = false;
  String? _error;

  UserPreferencesModel get preferences => _preferences;
  bool get isLoading => _isLoading;
  String? get error => _error;
  ThemeMode get themeMode => _resolveThemeMode(_preferences.theme);

  Future<void> init() async {
    _setLoading(true);
    try {
      UserPreferencesModel preferences = await _service.getPreferences();

      if (preferences.id == null) {
        preferences = await _service.createPreferences();
      }

      _preferences = preferences;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updatePreferences(UserPreferencesModel updated) async {
    _setLoading(true);
    try {
      await _service.updatePreferences(updated);
      _preferences = updated;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateTheme(ThemeType theme) async {
    await updatePreferences(_preferences.copyWith(theme: theme));
  }

  Future<void> toggleFocusMode() async {
    await updatePreferences(
      _preferences.copyWith(focusMode: !_preferences.focusMode),
    );
  }

  Future<void> toggleShowCompletedTasks() async {
    await updatePreferences(
      _preferences.copyWith(
        showCompletedTasks: !_preferences.showCompletedTasks,
      ),
    );
  }

  Future<void> toggleShowPendingTasks() async {
    await updatePreferences(
      _preferences.copyWith(showPendingTasks: !_preferences.showPendingTasks),
    );
  }

  ThemeMode _resolveThemeMode(ThemeType theme) {
    return switch (theme) {
      ThemeType.dark => ThemeMode.dark,
      ThemeType.light => ThemeMode.light,
      ThemeType.system => ThemeMode.system,
    };
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

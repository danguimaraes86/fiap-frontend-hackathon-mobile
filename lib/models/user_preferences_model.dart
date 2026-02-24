class UserPreferencesModel {
  final String? id;
  final String? userId;
  final ThemeType theme;
  final bool focusMode;
  final bool showCompletedTasks;
  final bool showPendingTasks;

  const UserPreferencesModel({
    this.id,
    this.userId,
    this.theme = ThemeType.light,
    this.focusMode = false,
    this.showCompletedTasks = true,
    this.showPendingTasks = true,
  });

  static const UserPreferencesModel defaultPreferences = UserPreferencesModel();

  UserPreferencesModel copyWith({
    String? id,
    String? userId,
    ThemeType? theme,
    bool? focusMode,
    bool? showCompletedTasks,
    bool? showPendingTasks,
  }) {
    return UserPreferencesModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      theme: theme ?? this.theme,
      focusMode: focusMode ?? this.focusMode,
      showCompletedTasks: showCompletedTasks ?? this.showCompletedTasks,
      showPendingTasks: showPendingTasks ?? this.showPendingTasks,
    );
  }

  factory UserPreferencesModel.fromJson(Map<String, dynamic> json) {
    return UserPreferencesModel(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      theme: ThemeType.fromValue(json['theme'] as String? ?? 'light'),
      focusMode: json['focusMode'] as bool? ?? false,
      showCompletedTasks: json['showCompletedTasks'] as bool? ?? true,
      showPendingTasks: json['showPendingTasks'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'theme': theme.value,
      'focusMode': focusMode,
      'showCompletedTasks': showCompletedTasks,
      'showPendingTasks': showPendingTasks,
    };
  }
}

enum ThemeType {
  light('light', 'Claro'),
  dark('dark', 'Escuro'),
  system('system', 'Auto');

  final String value;
  final String label;

  const ThemeType(this.value, this.label);

  static ThemeType fromValue(String value) {
    return ThemeType.values.firstWhere(
      (theme) => theme.value == value,
      orElse: () => ThemeType.light,
    );
  }
}

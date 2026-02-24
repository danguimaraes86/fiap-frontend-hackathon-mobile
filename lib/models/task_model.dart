import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Task {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final TaskStatus status;
  final DateTime? dueDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? completedAt;

  const Task({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    required this.status,
    this.dueDate,
    required this.createdAt,
    required this.updatedAt,
    this.completedAt,
  });

  Task withStatus(TaskStatus newStatus) {
    return Task(
      id: id,
      userId: userId,
      title: title,
      description: description,
      status: newStatus,
      dueDate: dueDate,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      completedAt: newStatus == TaskStatus.completed ? DateTime.now() : null,
    );
  }

  Task withUserId(String newUserId) {
    return Task(
      id: id,
      userId: newUserId,
      title: title,
      description: description,
      status: status,
      dueDate: dueDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
      completedAt: completedAt,
    );
  }

  static DateTime _toDateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.parse(value);
    throw ArgumentError('Formato de data inválido: $value');
  }

  static DateTime? _toDateTimeNullable(dynamic value) {
    if (value == null) return null;
    return _toDateTime(value);
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'description': description,
      'status': status.value,
      'dueDate': dueDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      status: TaskStatus.fromValue(json['status'] as String),
      dueDate: _toDateTimeNullable(json['dueDate']),
      createdAt: _toDateTime(json['createdAt']),
      updatedAt: _toDateTime(json['updatedAt']),
      completedAt: _toDateTimeNullable(json['completedAt']),
    );
  }
}

enum TaskStatus {
  pending('pending', 'Pendente', Icons.assignment_late, 'tertiary'),
  inProgress('in_progress', 'Em andamento', Icons.pending_actions, 'primary'),
  completed('completed', 'Concluída', Icons.task_alt, 'secondary');

  final String value;
  final String label;
  final IconData icon;
  final String color;

  const TaskStatus(this.value, this.label, this.icon, this.color);

  static TaskStatus fromValue(String value) {
    return TaskStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => TaskStatus.pending,
    );
  }
}

import 'package:flutter/material.dart';

class Todo {
  final String id;
  final String title;
  final String? description;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? dueDate;
  final String category;
  final Color categoryColor;
  final String priority; // Low | Medium | High

  Todo({
    String? id,
    required this.title,
    this.description,
    this.isCompleted = false,
    DateTime? createdAt,
    this.dueDate,
    this.category = 'Personal',
    required this.categoryColor,
    this.priority = 'Medium',
  })  : id = id ?? UniqueKey().toString(),
        createdAt = createdAt ?? DateTime.now();

  Todo copyWith({
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? dueDate,
    String? category,
    Color? categoryColor,
    String? priority,
  }) {
    return Todo(
      id: id, // keep id stable
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      category: category ?? this.category,
      categoryColor: categoryColor ?? this.categoryColor,
      priority: priority ?? this.priority,
    );
  }

  bool get isOverdue => dueDate != null && dueDate!.isBefore(DateTime.now());

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'isCompleted': isCompleted,
        'createdAt': createdAt.toIso8601String(),
        'dueDate': dueDate?.toIso8601String(),
        'category': category,
        // If your SDK warns about .value being deprecated, you can keep it (it compiles),
        // or switch to toARGB32() in newer Flutter versions:
        'categoryColor': categoryColor.value,
        'priority': priority,
      };

  static Todo fromMap(Map<String, dynamic> m) {
    return Todo(
      id: (m['id'] as String?) ?? UniqueKey().toString(),
      title: m['title'] as String,
      description: m['description'] as String?,
      isCompleted: (m['isCompleted'] as bool?) ?? false,
      createdAt: DateTime.tryParse(m['createdAt'] as String? ?? '') ?? DateTime.now(),
      dueDate: (m['dueDate'] as String?) != null
          ? DateTime.tryParse(m['dueDate'] as String) // null-safe
          : null,
      category: (m['category'] as String?) ?? 'Personal',
      categoryColor: Color((m['categoryColor'] as int?) ?? 0xFF2196F3),
      priority: (m['priority'] as String?) ?? 'Medium',
    );
  }
}

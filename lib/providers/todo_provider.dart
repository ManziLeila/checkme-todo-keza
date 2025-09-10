import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/todo.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier() : super([]) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString('todos');
    if (jsonStr != null) {
      final List list = json.decode(jsonStr);
      state = list.map((e) => Todo.fromMap(e as Map<String, dynamic>)).toList();
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final list = state.map((t) => t.toMap()).toList();
    await prefs.setString('todos', json.encode(list));
  }

  void addTodo(Todo todo) {
    final _ = _save();
    state = [...state, todo];
  }

  void removeTodo(String id) {
    final _ = _save();
    state = state.where((todo) => todo.id != id).toList();
  }

  void toggleTodo(String id) {
    final _ = _save();
    state = state.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(isCompleted: !todo.isCompleted);
      }
      return todo;
    }).toList();
  }

  void updateTodo(Todo updatedTodo) {
    final _ = _save();
    state = state.map((todo) {
      if (todo.id == updatedTodo.id) {
        return updatedTodo;
      }
      return todo;
    }).toList();
  }
}

final todoListProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) {
  return TodoListNotifier();
});
// providers/todo_provider.dart
import 'package:flutter/material.dart';
import '../models/todo_item.dart';
import 'package:uuid/uuid.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> todos = [];

  // Metode untuk menambah tugas
  void addTodoItem(String task, String day) {
    todos.add(Todo(task: task, day: day, isDone: false));
    notifyListeners();
  }

  // Metode untuk menghapus tugas
  void removeTodoItem(int index) {
    todos.removeAt(index);
    notifyListeners();
  }

  // Metode untuk mendapatkan tugas berdasarkan hari
  List<Todo> getTodosByDay(String day) {
    return todos.where((todo) => todo.day == day).toList();
  }

  // Metode untuk mengubah status tugas
  void toggleTodoStatus(int index) {
    todos[index].isDone = !todos[index].isDone;
    notifyListeners();
  }
}



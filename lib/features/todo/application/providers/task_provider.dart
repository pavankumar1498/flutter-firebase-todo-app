import 'package:flutter/material.dart';
import '../../data/models/task_model.dart';
import '../../data/services/task_service.dart';

class TaskProvider with ChangeNotifier {
  final TaskService _taskService = TaskService();

  List<Task> _tasks = [];

  bool _loading = false;

  String? _error;

  List<Task> get tasks => _tasks;

  bool get loading => _loading;

  String? get error => _error;

  Future<void> loadTasks(String userId) async {
    try {
      _loading = true;
      _error = null;

      notifyListeners();

      _tasks = await _taskService.fetchTasks(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;

      notifyListeners();
    }
  }

  Future<void> addTask(String userId, String title) async {
    try {
      _loading = true;

      notifyListeners();

      final newTask = Task(id: '', title: title, completed: false);

      await _taskService.addTask(userId, newTask);

      await loadTasks(userId);
    } catch (e) {
      _error = e.toString();

      notifyListeners();
    }
  }

  Future<void> toggleCompleted(
    String userId,
    String taskId,
    bool completed,
  ) async {
    try {
      await _taskService.toggleTask(userId, taskId, completed);

      final index = tasks.indexWhere((t) => t.id == taskId);

      if (index != -1) {
        tasks[index] = Task(
          id: tasks[index].id,
          title: tasks[index].title,
          completed: completed,
        );
      }

      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> editTask(String userId, Task task) async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();

      await _taskService.updateTask(userId, task.id, task);

      await loadTasks(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> deleteTask(String userId, String taskId) async {
    try {
      await _taskService.deleteTask(userId, taskId);

      _tasks.removeWhere((task) => task.id == taskId);

      notifyListeners();
    } catch (e) {
      _error = e.toString();

      notifyListeners();
    }
  }

  Future<void> refreshTasks(String userId) async {
    await loadTasks(userId);
  }

  void clearTasks() {
    _tasks = [];

    notifyListeners();
  }
}

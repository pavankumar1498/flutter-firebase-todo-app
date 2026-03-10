import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task_model.dart';

class TaskService {
  final String baseUrl =
      "https://todo-firebase-app-1f9a9-default-rtdb.firebaseio.com";

  Future<List<Task>> fetchTasks(String userId) async {
    try {
      final url = Uri.parse("$baseUrl/tasks/$userId.json");

      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw Exception("Failed to fetch tasks");
      }

      final data = jsonDecode(response.body);

      if (data == null) return [];

      final List<Task> tasks = [];

      data.forEach((id, value) {
        tasks.add(Task.fromJson(id, value));
      });

      return tasks;
    } catch (e) {
      throw Exception("Error loading tasks");
    }
  }

  Future<void> addTask(String userId, Task task) async {
    try {
      final url = Uri.parse("$baseUrl/tasks/$userId.json");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(task.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to add task");
      }
    } catch (e) {
      throw Exception("Error adding task");
    }
  }

  Future<void> updateTask(String userId, String taskId, Task task) async {
    try {
      final url = Uri.parse("$baseUrl/tasks/$userId/$taskId.json");

      final response = await http.patch(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(task.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to update task");
      }
    } catch (e) {
      throw Exception("Error updating task: $e");
    }
  }

  Future<void> toggleTask(String userId, String taskId, bool completed) async {
    try {
      final url = Uri.parse("$baseUrl/tasks/$userId/$taskId.json");

      final response = await http.patch(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"completed": completed}),
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to update task status");
      }
    } catch (e) {
      throw Exception("Error updating task status: $e");
    }
  }

  Future<void> deleteTask(String userId, String taskId) async {
    try {
      final url = Uri.parse("$baseUrl/tasks/$userId/$taskId.json");

      final response = await http.delete(url);

      if (response.statusCode != 200) {
        throw Exception("Failed to delete task");
      }
    } catch (e) {
      throw Exception("Error deleting task");
    }
  }
}

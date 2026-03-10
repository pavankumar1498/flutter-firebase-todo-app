import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase_app/core/utils/utils.dart';
import 'package:todo_firebase_app/features/todo/application/providers/auth_provider.dart';
import 'package:todo_firebase_app/features/todo/application/providers/task_provider.dart';
import 'package:todo_firebase_app/features/todo/data/models/task_model.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  const EditTaskScreen({super.key, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.task.title);
  }

  Future<void> updateTask() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    final updatedTask = Task(
      id: widget.task.id,
      title: controller.text,
      completed: widget.task.completed,
    );

    try {
      await Provider.of<TaskProvider>(
        context,
        listen: false,
      ).editTask(auth.user!.uid, updatedTask);

      AppUtils.showSuccessSnackBar(context, "Task updated");

      Navigator.pop(context);
    } catch (e) {
      AppUtils.showErrorSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Edit Task"),
        backgroundColor: Colors.blue,
      ),

      body: Center(
        child: SizedBox(
          width: width * 0.85,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(labelText: "Task Title"),
              ),

              const SizedBox(height: 25),

              ElevatedButton(
                onPressed: updateTask,
                child: const Text("Update Task"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

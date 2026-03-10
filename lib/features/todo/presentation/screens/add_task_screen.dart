import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase_app/core/utils/utils.dart';
import 'package:todo_firebase_app/features/todo/application/providers/auth_provider.dart';
import 'package:todo_firebase_app/features/todo/application/providers/task_provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final controller = TextEditingController();

  Future<void> addTask() async {
    try {
      final auth = Provider.of<AuthProvider>(context, listen: false);

      await Provider.of<TaskProvider>(
        context,
        listen: false,
      ).addTask(auth.user!.uid, controller.text);

      AppUtils.showSuccessSnackBar(context, "Task Added Successfully");

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
        title: const Text("Add Task"),
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
                onPressed: addTask,
                child: const Text("Save Task"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

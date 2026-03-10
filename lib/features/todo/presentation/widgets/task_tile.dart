import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase_app/core/utils/utils.dart';
import 'package:todo_firebase_app/features/todo/application/providers/auth_provider.dart'
    show AuthProvider;
import 'package:todo_firebase_app/features/todo/presentation/screens/edit_task_screen.dart';
import '../../application/providers/task_provider.dart';
import '../../data/models/task_model.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    return Card(
      color: Colors.white70,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),

      child: ListTile(
        leading: Checkbox(
          value: task.completed,

          onChanged: (value) async {
            await Provider.of<TaskProvider>(
              context,
              listen: false,
            ).toggleCompleted(auth.user!.uid, task.id, value!);

            AppUtils.showSuccessSnackBar(context, "Task status updated");
          },
        ),

        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.completed ? TextDecoration.lineThrough : null,
          ),
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EditTaskScreen(task: task)),
                );
              },
            ),

            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                await Provider.of<TaskProvider>(
                  context,
                  listen: false,
                ).deleteTask(auth.user!.uid, task.id);

                AppUtils.showSuccessSnackBar(context, "Task deleted");
              },
            ),
          ],
        ),
      ),
    );
  }
}

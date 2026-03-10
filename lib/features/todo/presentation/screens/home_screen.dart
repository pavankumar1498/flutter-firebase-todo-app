import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase_app/core/utils/utils.dart';
import 'package:todo_firebase_app/features/todo/application/providers/auth_provider.dart';
import 'package:todo_firebase_app/features/todo/application/providers/task_provider.dart';
import 'package:todo_firebase_app/features/todo/presentation/widgets/task_tile.dart';
import 'add_task_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      Provider.of<TaskProvider>(
        context,
        listen: false,
      ).loadTasks(auth.user!.uid);
    });
  }

  Future<void> refreshTasks() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    await Provider.of<TaskProvider>(
      context,
      listen: false,
    ).loadTasks(auth.user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("My Tasks"),
        backgroundColor: Colors.blue,

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),

            onPressed: () async {
              await auth.logout();
              AppUtils.showSuccessSnackBar(context, "Logged Out");

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,

        child: const Icon(Icons.add),

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTaskScreen()),
          );
        },
      ),

      body: RefreshIndicator(
        onRefresh: refreshTasks,

        child: Builder(
          builder: (context) {
            if (provider.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.error != null) {
              return Center(child: Text(provider.error!));
            }

            if (provider.tasks.isEmpty) {
              return const Center(child: Text("No tasks found"));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(10),

              itemCount: provider.tasks.length,

              itemBuilder: (context, index) {
                final task = provider.tasks[index];

                return TaskTile(task: task);
              },
            );
          },
        ),
      ),
    );
  }
}

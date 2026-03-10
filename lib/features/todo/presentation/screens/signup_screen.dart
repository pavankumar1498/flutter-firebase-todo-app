import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase_app/core/utils/utils.dart';
import 'package:todo_firebase_app/features/todo/application/providers/auth_provider.dart';
import 'package:todo_firebase_app/features/todo/presentation/screens/login_screen.dart';
import 'home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signup() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    await auth.signup(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (auth.error == null) {
      AppUtils.showSuccessSnackBar(context, "Registration Successful");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } else {
      AppUtils.showErrorSnackBar(context, auth.error!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(title: const Text("Signup"), backgroundColor: Colors.blue),

      body: Center(
        child: SizedBox(
          width: width * 0.85,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
              ),

              const SizedBox(height: 25),

              auth.loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: signup,
                      child: const Text("Signup"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

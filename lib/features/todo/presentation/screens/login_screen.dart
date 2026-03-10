import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase_app/core/utils/utils.dart';
import 'package:todo_firebase_app/features/todo/application/providers/auth_provider.dart';
import 'signup_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    await auth.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (auth.error == null) {
      AppUtils.showSuccessSnackBar(context, "Login Successful");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
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

      appBar: AppBar(title: const Text("Login"), backgroundColor: Colors.blue),

      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: width * 0.85,

            child: Column(
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
                        onPressed: login,
                        child: const Text("Login"),
                      ),

                const SizedBox(height: 15),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignupScreen()),
                    );
                  },
                  child: const Text("Create Account"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

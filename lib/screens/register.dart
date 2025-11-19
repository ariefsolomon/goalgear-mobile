import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  // Username
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Password
                  TextField(
                    controller: _password1Controller,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),

                  const SizedBox(height: 12),

                  // Confirm Password
                  TextField(
                    controller: _password2Controller,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),

                  const SizedBox(height: 20),

                  // Register button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _loading
                          ? null
                          : () async {
                              setState(() => _loading = true);

                              final response = await request.postJson(
                                // GANTI URL untuk emulator
                                "http://localhost:8000/auth/register/",
                                jsonEncode({
                                  "username": _usernameController.text,
                                  "password1": _password1Controller.text,
                                  "password2": _password2Controller.text,
                                }),
                              );

                              setState(() => _loading = false);

                              if (response['status'] == 'success') {
                                if (!mounted) return;

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Successfully registered!'),
                                  ),
                                );

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LoginPage(),
                                  ),
                                );
                              } else {
                                if (!mounted) return;

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      response['message'] ??
                                          'Failed to register.',
                                    ),
                                  ),
                                );
                              }
                            },
                      child: _loading
                          ? const CircularProgressIndicator()
                          : const Text('Register'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

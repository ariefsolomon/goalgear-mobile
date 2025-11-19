import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'menu.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _user = TextEditingController();
  final _pass = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _user,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _pass,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: _loading
                        ? null
                        : () async {
                            setState(() => _loading = true);

                            final resp = await request.login(
                              "http://localhost:8000/auth/login/",
                              {"username": _user.text, "password": _pass.text},
                            );

                            setState(() => _loading = false);

                            if (request.loggedIn) {
                              if (!mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    resp['message'] ?? 'Login success',
                                  ),
                                ),
                              );

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => MyHomePage()),
                              );
                            } else {
                              if (!mounted) return;

                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Login failed'),
                                  content: Text(
                                    resp['message'] ??
                                        'Login gagal. Periksa username/password.',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },

                    child: _loading
                        ? const CircularProgressIndicator()
                        : const Text('Login'),
                  ),

                  const SizedBox(height: 12),

                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterPage()),
                    ),
                    child: Text(
                      "Don't have account? Register",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
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

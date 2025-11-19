import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:goalgear_mobile/screens/menu.dart';
import 'package:goalgear_mobile/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Provider<CookieRequest>(
      create: (_) => CookieRequest(),
      child: MaterialApp(
        title: 'GoalGear Mobile',
        theme: ThemeData(useMaterial3: true),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginPage(),
          '/home': (context) => MyHomePage(),
        },
        home: const LoginPage(),
      ),
    );
  }
}

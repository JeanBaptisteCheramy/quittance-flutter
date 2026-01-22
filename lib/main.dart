import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quittance_app/components/screens/HomeScreen/HomeScreen.dart';
import 'package:quittance_app/components/screens/account/AccountScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: Color.fromARGB(255, 42, 30, 98),
          onPrimary: Colors.white,
          secondary: Color.fromARGB(255, 169, 157, 239),
          onSecondary: Color.fromARGB(255, 42, 30, 98),
          tertiary: Color.fromARGB(255, 197, 152, 97),
        ),
      ),
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(path: "/", builder: (context, state) => HomeScreen()),
    GoRoute(path: "/account", builder: (context, state) => AccountScreen()),
  ],
);

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quittance_app/components/screens/HomeScreen/HomeScreen.dart';
import 'package:quittance_app/components/screens/account/Account.dart';

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
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
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


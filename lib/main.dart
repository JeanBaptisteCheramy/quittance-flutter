import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quittance_app/components/screens/QuittancesScreen/quittances_screen.dart';
import 'package:quittance_app/components/screens/RentalsScreen/rentals_screen.dart';
import 'package:quittance_app/components/screens/RentersScreen/renters_screen.dart';

import 'components/screens/AccountScreen/account_screen.dart';
import 'components/screens/RentersScreen/renter_form.dart';
import 'database/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseHelper.instance.database;
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
    GoRoute(path: "/", builder: (context, state) => QuittancesScreen()),
    GoRoute(path: "/account", builder: (context, state) => AccountScreen()),
    GoRoute(path: "/renters", builder: (context, state) => RentersScreen()),
    GoRoute(path: "/rentals", builder: (context, state) => RentalsScreen()),
    GoRoute(path: '/renterForm', builder: (context, state) => RenterForm()),
    GoRoute(
      path: '/renterForm/:id?',
      builder: (context, state) {
        final idParam = state.pathParameters['id'];
        final id = idParam != null ? int.tryParse(idParam) : null;

        return RenterForm(id: id);
      },
    ),
  ],
);

extension CustomColors on ColorScheme {
  Color get disabled => const Color.fromARGB(255, 115, 115, 115);

  Color get onDisabled => const Color.fromARGB(255, 204, 204, 204);

  Color get validate => const Color.fromARGB(255, 42, 30, 98);

  Color get cancel => const Color.fromARGB(255, 165, 57, 57);
}

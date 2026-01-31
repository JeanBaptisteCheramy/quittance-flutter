import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<CustomBottomNavigationBar> {

  void _onLinkTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          context.go('/');
        case 1:
          context.go('/rentals');
        case 2:
          context.go('/tenants');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    int _locationToIndex(String location) {
      if (location.startsWith('/rentals')) return 1;
      if (location.startsWith('/tenants')) return 2;
      return 0;
    }

    return BottomNavigationBar(
      currentIndex: _locationToIndex(location),
      onTap: _onLinkTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.article),
          label: 'Mes quittances',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Locations'),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_pin),
          label: 'Locataires',
        ),
      ],
    );
  }
}

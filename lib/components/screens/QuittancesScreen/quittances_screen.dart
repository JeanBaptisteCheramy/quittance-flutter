import 'package:flutter/material.dart';
import 'package:quittance_app/main.dart';

import '../../common/AppBar/custom_app_bar.dart';
import '../../common/custom_bottom_navigation.dart';

class QuittancesScreen extends StatefulWidget {
  @override
  State<QuittancesScreen> createState() => _QuittancesScreenState();
}

class _QuittancesScreenState extends State<QuittancesScreen> {
  bool isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Quittances", showAccountButton: true),
      floatingActionButton: FloatingActionButton(
        onPressed: isButtonEnabled ? () {} : null,
        backgroundColor: isButtonEnabled
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.disabled,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        child: Icon(
          Icons.add_rounded,
          color: isButtonEnabled
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.onDisabled,
          size: 40,
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

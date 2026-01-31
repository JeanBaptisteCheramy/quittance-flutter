import 'package:flutter/material.dart';

import '../../common/AppBar/custom_app_bar.dart';
import '../../common/custom_bottom_navigation.dart';

class RentalsScreen extends StatefulWidget {
  @override
  State<RentalsScreen> createState() => _RentalsScreenState();
}

class _RentalsScreenState extends State<RentalsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Locations"),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
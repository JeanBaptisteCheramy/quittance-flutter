import 'package:flutter/material.dart';

import '../../common/AppBar/CustomAppBar.dart';
import '../../common/CustomBottomNavigation.dart';

class TenantsScreen extends StatefulWidget {
  @override
  State<TenantsScreen> createState() => _TenantsScreenState();
}

class _TenantsScreenState extends State<TenantsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title:"Locataires"),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
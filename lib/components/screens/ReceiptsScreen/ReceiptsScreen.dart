import 'package:flutter/material.dart';

import '../../common/AppBar/CustomAppBar.dart';
import '../../common/CustomBottomNavigation.dart';

class ReceiptsScreen extends StatefulWidget {
  @override
  State<ReceiptsScreen> createState() => _ReceiptsScreenState();
}

class _ReceiptsScreenState extends State<ReceiptsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Quittances"),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
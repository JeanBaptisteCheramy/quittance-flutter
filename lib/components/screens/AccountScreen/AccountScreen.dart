import 'package:flutter/material.dart';
import 'package:quittance_app/components/common/AppBar/CustomAppBar.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Compte", showBackButton: true),
      body: Text('Account page'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quittance_app/components/screens/TenantsScreen/tenant_form.dart';
import '../../common/AppBar/custom_app_bar.dart';
import '../../common/custom_bottom_navigation.dart';

class TenantsScreen extends StatefulWidget {
  @override
  State<TenantsScreen> createState() => _TenantsScreenState();
}

class _TenantsScreenState extends State<TenantsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Locataires", showBackButton: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/tenantForm'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        child: Icon(
          Icons.add_rounded,
          color: Theme.of(context).colorScheme.primary,
          size: 40,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade300),
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: ListTile(
          tileColor: Theme.of(context).colorScheme.onPrimary,
          leading: const Icon(Icons.person),
          title: const Text('Nom Prénom'),
          subtitle: const Text('Adresse'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.edit),
              SizedBox(width: 16),
              Icon(Icons.delete),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

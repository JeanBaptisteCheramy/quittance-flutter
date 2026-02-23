import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quittance_app/models/tenant_model.dart';
import '../../../service/tenant_service.dart';
import '../../common/AppBar/custom_app_bar.dart';
import '../../common/custom_bottom_navigation.dart';

class TenantsScreen extends StatefulWidget {
  @override
  State<TenantsScreen> createState() => _TenantsScreenState();
}

class _TenantsScreenState extends State<TenantsScreen> {
  final TenantService _service = TenantService();
  late List<TenantModel?> tenants = [];

  @override
  void initState() {
    super.initState();
    _loadAllTenants();
  }

  Future<void> _loadAllTenants() async {
    final result = await _service.getAll();

    if (result.isNotEmpty) {
      setState(() {
        tenants = result;
      });
    }
  }

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
        child: ListView.builder(
          itemCount: tenants.length,
          itemBuilder: (context, index) {
            final tenant = tenants[index];
            return Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              child: ListTile(
                title: Text("${tenant?.firstName} ${tenant?.lastName}"),
                leading: const Icon(Icons.person),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.edit),
                    SizedBox(width: 16),
                    Icon(Icons.delete),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

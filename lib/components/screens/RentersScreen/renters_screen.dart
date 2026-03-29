import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quittance_app/models/renter_model.dart';
import '../../../service/renter_service.dart';
import '../../common/AppBar/custom_app_bar.dart';
import '../../common/custom_bottom_navigation.dart';

class RentersScreen extends StatefulWidget {
  const RentersScreen({super.key});

  @override
  State<RentersScreen> createState() => _RentersScreenState();
}

class _RentersScreenState extends State<RentersScreen> {
  final RenterService _service = RenterService();
  late List<RenterModel?> renters = [];

  @override
  void initState() {
    super.initState();
    _loadAllRenters();
  }

  Future<void> _loadAllRenters() async {
    final result = await _service.getAll();

    if (result.isNotEmpty) {
      setState(() {
        renters = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Locataires", showBackButton: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/renterForm'),
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
          itemCount: renters.length,
          itemBuilder: (context, index) {
            final renter = renters[index];
            return Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              child: ListTile(
                title: Text("${renter?.firstName} ${renter?.lastName}"),
                leading: const Icon(Icons.person),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () =>
                          context.push('/renterForm/${renter!.id}'),
                      icon: Icon(Icons.edit),
                    ),
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

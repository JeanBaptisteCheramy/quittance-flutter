import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../main.dart';
import '../../../models/tenant_model.dart';
import '../../../service/tenant_service.dart';
import '../../../utils/validators/validators.dart';
import '../../common/AppBar/custom_app_bar.dart';

class TenantForm extends StatefulWidget {
  const TenantForm({super.key});

  @override
  State<TenantForm> createState() => _TenantFormState();
}

class _TenantFormState extends State<TenantForm> {
  final TenantService _service = TenantService();

  bool formMode = false;
  final _formKey = GlobalKey<FormState>();

  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Compte",
        showBackButton: formMode ? false : true,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 10,
                children: [
                  const Text(
                    "Nom",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    validator: Validators.nameValidator,
                    controller: _lastNameController,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Prénom",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    validator: Validators.nameValidator,
                    controller: _firstNameController,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Adresse",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    validator: Validators.addressValidator,
                    controller: _addressController,
                    maxLines: 2,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.validate,
                    ),
                    onPressed: _onSubmit,
                    child: Text(
                      'Enregistrer',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _goToTenantsPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.cancel,
                    ),
                    child: Text(
                      'Annuler',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // gerer si update ou create - voir formMode
  void _onSubmit() async {
    print(_formKey.currentState);
    if (_formKey.currentState!.validate()) {
      final newTenant = TenantModel(
        id: null,
        lastName: _lastNameController.text,
        firstName: _firstNameController.text,
        address: _addressController.text,
      );


      // create or update automatiquement
      await _service.save(newTenant);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(
            child: Text('Locataire enregistré', style: TextStyle(fontSize: 20)),
          ),
        ),
      );

      _goToTenantsPage();
    }
  }

  void _goToTenantsPage() {
    context.push("/tenants");
  }

  void _switchUpdateMode() {
    formMode = !formMode;
  }
}

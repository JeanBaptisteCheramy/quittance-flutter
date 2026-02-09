import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../../utils/validators/validators.dart';
import '../../common/AppBar/custom_app_bar.dart';

class TenantForm extends StatefulWidget {
  const TenantForm({super.key});

  @override
  State<TenantForm> createState() => _TenantFormState();
}

class _TenantFormState extends State<TenantForm> {
  bool formMode = false;

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
      body: Center(
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
                  onPressed: _switchUpdateMode,
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
    );
  }

  void _onSubmit() {}

  void _switchUpdateMode() {}
}

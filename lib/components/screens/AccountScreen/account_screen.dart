import 'package:flutter/material.dart';
import 'package:quittance_app/components/common/AppBar/custom_app_bar.dart';
import 'package:quittance_app/main.dart';
import 'package:quittance_app/models/owner_model.dart';
import 'package:quittance_app/service/owner_service.dart';
import 'package:quittance_app/utils/validators/validators.dart';

class AccountScreen extends StatefulWidget {
  final int id = 1;

  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final OwnerService _service = OwnerService();
  final _formKey = GlobalKey<FormState>();
  bool formMode = false;

  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _addressController = TextEditingController();

  late OwnerModel owner;

  @override
  void initState() {
    super.initState();
    _loadOwner();
  }

  Future<void> _loadOwner() async {
    final result = await _service.getById(widget.id);

    if (result != null) {
      setState(() {
        owner = result;
        formMode = false; // mode lecture
        _lastNameController.text = owner.lastName;
        _firstNameController.text = owner.firstName;
        _addressController.text = owner.address;
      });
    } else {
      setState(() {
        formMode = true; // premier accès, form vide
      });
    }
  }


  void _switchUpdateMode() {
    setState(() {
      formMode = !formMode;
    });
  }

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      final singletonOwner = OwnerModel(
        id: 1,
        lastName: _lastNameController.text,
        firstName: _firstNameController.text,
        address: _addressController.text,
      );

      // create or update automatiquement
      await _service.save(singletonOwner);

      await _loadOwner();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(
            child: Text('Compte enregistré', style: TextStyle(fontSize: 20)),
          ),
        ),
      );

      setState(() {
        formMode = false; // retour en lecture
      });
    }
  }

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
            child: formMode
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 10,
                      children: [
                        const Text(
                          "Nom",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          validator: Validators.nameValidator,
                          controller: _lastNameController,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Prénom",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          validator: Validators.nameValidator,
                          controller: _firstNameController,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Adresse",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          validator: Validators.addressValidator,
                          controller: _addressController,
                          maxLines: 2,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.validate,
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
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.cancel,
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
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _infoRow('Nom', owner.lastName),
                      _infoRow('Prénom', owner.firstName),
                      _infoRow('Adresse', owner.address),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.validate,
                          ),
                          onPressed: _switchUpdateMode,
                          child: Text(
                            'Modifier',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
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
}

Widget _infoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(value, style: const TextStyle(fontSize: 16)),
        ),
      ],
    ),
  );
}

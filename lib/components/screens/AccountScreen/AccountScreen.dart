import 'package:flutter/material.dart';
import 'package:quittance_app/components/common/AppBar/CustomAppBar.dart';
import 'package:quittance_app/main.dart';
import 'package:quittance_app/models/LessorModel.dart';
import 'package:quittance_app/service/LessorService.dart';

class AccountScreen extends StatefulWidget {
  final int id = 1;

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final LessorService _service = LessorService();
  final _formKey = GlobalKey<FormState>();
  bool hasError = false;
  bool updateMode = false;
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _addressController = TextEditingController();
  late LessorModel lessor;

  String? _nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Le champ est obligatoire';
    }
    if (value.length < 2) {
      return 'Le champ doit contenir au moins 2 caractères';
    }
    return null;
  }

  String? _addressValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Le champ est obligatoire';
    }
    if (value.length < 10) {
      return 'Le champ doit contenir au moins 10 caractères';
    }
    return null;
  }

  @override
  void initState() {
    _loadLessor();
    super.initState();
  }

  Future<void> _loadLessor() async {
    final result = await _service.find(widget.id);
    if (result != null) {
      setState(() {
        lessor = result;
        _lastNameController.text = lessor.lastName;
        _firstNameController.text = lessor.firstName;
        _addressController.text = lessor.address;
      });
    } else {
      _switchUpdateMode();
    }
  }

  void _switchUpdateMode() {
    setState(() {
      updateMode = !updateMode;
    });
  }

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      final lessor = LessorModel(
        lastName: _lastNameController.text,
        firstName: _firstNameController.text,
        address: _addressController.text,
      );
      if (updateMode) {
        final id = await _service.update(lessor);
      } else {
        final id = await _service.create(lessor);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Compte", showBackButton: true),
      body: Form(
        key: _formKey,
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: updateMode
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text("Nom"),
                      TextFormField(
                        validator: _nameValidator,
                        controller: _lastNameController,
                      ),
                      const SizedBox(height: 16),
                      const Text("Prénom"),
                      TextFormField(
                        validator: _nameValidator,
                        controller: _firstNameController,
                      ),
                      const SizedBox(height: 16),
                      const Text("Adresse"),
                      TextFormField(
                        validator: _addressValidator,
                        controller: _addressController,
                        minLines: 3,
                        maxLines: 5,
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
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Nom : ${lessor.lastName}'),
                      Text('Prénom : ${lessor.firstName}'),
                      Text('Addresse : ${lessor.address}'),
                      ElevatedButton(
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
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

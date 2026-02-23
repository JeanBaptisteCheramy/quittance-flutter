import 'package:quittance_app/models/lessor_model.dart';
import 'package:quittance_app/models/tenant_model.dart';
import 'package:quittance_app/repository/lessor_repository.dart';

import '../repository/tenant_repository.dart';

class TenantService {
  final TenantRepository _repository = TenantRepository();

  /// Méthode save pour le tenant
  /// Pas de return
  /// Permet de créer / mettre à jour les informations du locataire
  Future<void> save(TenantModel tenant) async {
    await _repository.save(tenant);
  }

  Future<List<TenantModel?>> getAll() async{
    return await _repository.getAll();
  }

}

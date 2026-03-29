import 'package:quittance_app/models/owner_model.dart';
import 'package:quittance_app/repository/owner_repository.dart';

class OwnerService {
  final OwnerRepository _repository = OwnerRepository();

  /// Méthode save pour le owner
  /// Pas de return
  /// Permet de créer / mettre à jour les informations du propriétaire
  Future<void> save(OwnerModel owner) async {
    await _repository.saveSingleton(owner);
  }

  /// Récupérer le owner par ID
  ///
  /// [id] === 1 (singleton, un seul propriétaire)
  /// return [OwnerModel] ou null
  Future<OwnerModel?> getById(int id) {
    return _repository.getById(id);
  }
}

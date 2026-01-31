import 'package:quittance_app/models/lessor_model.dart';
import 'package:quittance_app/repository/lessor_repository.dart';

class LessorService {
  final LessorRepository _repository = LessorRepository();

  /// Méthode save pour le lessor
  /// Pas de return
  /// Permet de créer / mettre à jour les informations du propriétaire
  Future<void> save(LessorModel lessor) async {
    await _repository.saveSingleton(lessor);
  }

  /// Récupérer le lessor par ID
  ///
  /// [id] === 1 (singleton, un seul propriétaire)
  /// return [LessorModel] ou null
  Future<LessorModel?> getById(int id) {
    return _repository.getById(id);
  }
}

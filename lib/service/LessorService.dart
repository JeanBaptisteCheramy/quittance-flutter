import 'package:quittance_app/models/LessorModel.dart';
import '../database/database-helper.dart';

class LessorService {
  final DatabaseHelper _db = DatabaseHelper.instance;

  // Méthode unique pour créer ou mettre à jour le lessor singleton
  Future<void> save(LessorModel lessor) async {
    await _db.saveSingletonLessor(lessor.toMap());
  }

  // Récupérer le lessor par ID (toujours 1 pour le singleton)
  Future<LessorModel?> find(int id) async {
    final result = await _db.getLessorById(id);
    if (result.isNotEmpty) {
      return LessorModel.fromMap(result.first);
    }
    return null;
  }
}

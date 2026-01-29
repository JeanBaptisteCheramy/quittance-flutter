import 'package:quittance_app/models/LessorModel.dart';

import '../database/database-helper.dart';

class LessorService {
  final DatabaseHelper _db = DatabaseHelper.instance;

  Future<int> create(LessorModel lessor) {
    return _db.insertLessor(lessor.toMap());
  }

  Future<LessorModel?> find(int id) async {
    final result = await _db.getLessorById(id);

    if (result.isNotEmpty) {
      return LessorModel.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<bool> update(LessorModel lessor) async {
    if (lessor.id == null) return false;
    final rowsAffected = await _db.updateLessor(lessor.id!, lessor.toMap());
    return rowsAffected > 0;
  }
}

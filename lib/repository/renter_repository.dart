import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/renter_model.dart';
import 'interface_repository.dart';

class RenterRepository implements InterfaceRepository<RenterModel> {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  @override
  Future<int> save(RenterModel renter) async {
    if (renter.id == null) {
      // Insert
      return await _dbHelper.insert(
        'renters',
        renter.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      // Update
      return await _dbHelper.update(
        'renters',
        renter.toMap(),
        renter.id!,
      );
    }
  }

  @override
  Future<List<RenterModel>> getAll() async {
    final rows = await _dbHelper.findAll('renters');
    return rows.map((row) => RenterModel.fromMap(row)).toList();
  }

  @override
  Future<RenterModel?> getById(int id) async {
    final rows = await _dbHelper.findById('renters', id);
    if (rows.isNotEmpty) {
      return RenterModel.fromMap(rows.first);
    }
    return null;
  }

  @override
  Future<int> delete(int id) async {
    return await _dbHelper.delete('renters', id);
  }
}

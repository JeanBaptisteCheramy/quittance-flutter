import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/tenant_model.dart';
import 'interface_repository.dart';

class TenantRepository implements InterfaceRepository<TenantModel> {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  @override
  Future<int> save(TenantModel tenant) async {
    if (tenant.id == null) {
      // Insert
      return await _dbHelper.insert(
        'tenants',
        tenant.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      // Update
      return await _dbHelper.update(
        'tenants',
        tenant.toMap(),
        tenant.id!,
      );
    }
  }

  @override
  Future<List<TenantModel>> getAll() async {
    final rows = await _dbHelper.findAll('tenants');
    return rows.map((row) => TenantModel.fromMap(row)).toList();
  }

  @override
  Future<TenantModel?> getById(int id) async {
    final rows = await _dbHelper.findById('tenants', id);
    if (rows.isNotEmpty) {
      return TenantModel.fromMap(rows.first);
    }
    return null;
  }

  @override
  Future<int> delete(int id) async {
    return await _dbHelper.delete('tenants', id);
  }
}
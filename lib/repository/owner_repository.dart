import 'package:sqflite/sqflite.dart';
import '../database/database_helper.dart';
import '../models/owner_model.dart';

class OwnerRepository  {

  final DatabaseHelper _database = DatabaseHelper.instance;


  Future<void> saveSingleton(OwnerModel owner) async {
    await _database.insert(
      'owners',
      { 'id': 1, ...owner.toMap() },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<OwnerModel>> getAll() async {
    final rows = await _database.findAll('owners');

    return rows
        .map((row) => OwnerModel.fromMap(row))
        .toList();
  }

  Future<OwnerModel?> getById(int id) async{
    final result = await _database.findById("owners", id);
        if (result.isNotEmpty){
          return OwnerModel.fromMap(result.first);
        }
        return null;
  }

}

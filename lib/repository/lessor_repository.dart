import 'package:sqflite/sqflite.dart';
import '../database/database_helper.dart';
import '../models/lessor_model.dart';

class LessorRepository  {

  final DatabaseHelper _database = DatabaseHelper.instance;


  Future<void> saveSingleton(LessorModel lessor) async {
    await _database.insert(
      'lessors',
      { 'id': 1, ...lessor.toMap() },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<LessorModel>> getAll() async {
    final rows = await _database.findAll('lessors');

    return rows
        .map((row) => LessorModel.fromMap(row))
        .toList();
  }

  Future<LessorModel?> getById(int id) async{
    final result = await _database.findById("lessors", id);
        if (result.isNotEmpty){
          return LessorModel.fromMap(result.first);
        }
        return null;
  }

}
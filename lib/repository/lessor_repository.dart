import 'package:sqflite/sqflite.dart';
import '../database/database-helper.dart';
import '../models/LessorModel.dart';

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
    final result = await _database.getById("lessors", id);
        if (result.isNotEmpty){
          return LessorModel.fromMap(result.first);
        }
        return null;
  }

  // Future<List<Map<String, Object?>>> getLessorById(int id) async {
  //   final db = await instance.database;
  //   return await db.query('lessors', where: 'id = ?', whereArgs: [id]);
  // }




}
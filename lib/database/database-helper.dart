import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('quittance.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE lessors (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        lastname TEXT NOT NULL,
        firstname TEXT NOT NULL,
        address TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE tenants (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstname TEXT NOT NULL,
        lastname TEXT NOT NULL,
        address TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE rentals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        address TEXT NOT NULL,
        lessor_id INTEGER NOT NULL,
        tenant_id INTEGER NOT NULL,
        FOREIGN KEY (lessor_id) REFERENCES lessors(id),
        FOREIGN KEY (tenant_id) REFERENCES tenants(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE receipts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        rental_id INTEGER NOT NULL,
        date_receipt TEXT NOT NULL,
        start_date TEXT NOT NULL,
        end_date TEXT NOT NULL,
        rent REAL NOT NULL,
        charges REAL NOT NULL,
        energy_saving REAL,
        total REAL NOT NULL,
        total_letter TEXT,
        payment_date TEXT,
        FOREIGN KEY (rental_id) REFERENCES rentals(id)
      )
    ''');
  }

  // ==================== INSERT =============================================
  Future<int> insertLessor(Map<String, dynamic> lessor) async {
    final db = await instance.database;
    return await db.insert('lessors', lessor);
  }

  // ==================== SINGLETON LESSOR ==================================
  Future<int> saveSingletonLessor(Map<String, dynamic> lessor) async {
    final db = await instance.database;

    // Force id = 1
    lessor['id'] = 1;

    return await db.insert(
      'lessors',
      lessor,
      conflictAlgorithm: ConflictAlgorithm.replace, // create or update
    );
  }

  Future<int> insertTenant(Map<String, dynamic> tenant) async {
    final db = await instance.database;
    return await db.insert('tenants', tenant);
  }

  Future<int> insertRental(Map<String, dynamic> rental) async {
    final db = await instance.database;
    return await db.insert('rentals', rental);
  }

  Future<int> insertReceipt(Map<String, dynamic> receipt) async {
    final db = await instance.database;
    return await db.insert('receipts', receipt);
  }

  // ==================== GET ================================================
  Future<List<Map<String, dynamic>>> getLessors() async {
    final db = await instance.database;
    return await db.query('lessors');
  }

  Future<List<Map<String, Object?>>> getLessorById(int id) async {
    final db = await instance.database;
    return await db.query('lessors', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getTenants() async {
    final db = await instance.database;
    return await db.query('tenants');
  }

  Future<List<Map<String, dynamic>>> getRentals() async {
    final db = await instance.database;
    return await db.query('rentals');
  }

  Future<List<Map<String, dynamic>>> getReceipts() async {
    final db = await instance.database;
    return await db.query('receipts');
  }

  // ==================== DELETE ============================================
  Future<int> deleteLessor(int id) async {
    final db = await instance.database;
    return await db.delete('lessors', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteTenant(int id) async {
    final db = await instance.database;
    return await db.delete('tenants', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteRental(int id) async {
    final db = await instance.database;
    return await db.delete('rentals', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteReceipt(int id) async {
    final db = await instance.database;
    return await db.delete('receipts', where: 'id = ?', whereArgs: [id]);
  }

  // ==================== UPDATE ============================================
  Future<int> updateLessor(int id, Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.update('lessors', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateTenant(int id, Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.update('tenants', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateRental(int id, Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.update('rentals', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateReceipt(int id, Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.update('receipts', row, where: 'id = ?', whereArgs: [id]);
  }
}

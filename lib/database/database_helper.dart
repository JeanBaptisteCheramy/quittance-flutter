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

  // ============ INSERT =======================================================

  /// Insert en base de donnée
  /// Retourne l'id de la donnée insérée
  Future<int> insert( String table, Map<String, dynamic> values, { ConflictAlgorithm? conflictAlgorithm}) async {
    final db = await instance.database;
    return await db.insert(table, values, conflictAlgorithm: conflictAlgorithm);
  }

  // ============ FIND ALL =====================================================

  /// Récupération de toutes les row d'une table
  /// Retourne une liste d'objets du type demandé
  Future<List<Map<String, dynamic>>> findAll(String table) async {
    final db = await instance.database;
    return await db.query(table);
  }

  // ============ FIND BY ID ===================================================

  /// Récupère une row par son id
  /// Retourne une liste :
  /// - vide si aucune donnée
  /// - contenant une seule map sinon
  Future<List<Map<String, dynamic>>> findById(String table, int id) async {
    final db = await instance.database;
    return await db.query(table, where: 'id = ?', whereArgs: [id]);
  }

  // ============ UPDATE =======================================================

  /// Update d'une row à l'id
  /// Retourne le nombre de row modifiées
  Future<int> update(String table, Map<String, dynamic> values, int id ) async {
    final db = await instance.database;
    return await db.update(table, values, where: 'id = ?',whereArgs: [id]);
  }

  // ============ DELETE =======================================================

  /// Suppression d'une row
  /// Retourne le nombre de row supprimées
  Future<int> delete(String table, int id) async {
    final db = await instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

}

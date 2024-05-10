import 'package:lossy/database/database_service.dart';
import 'package:lossy/model/weight.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class weightEntry {
  final tableName = 'weight';

  Future<Database> _getDatabase() async {
    final path = await _dbPath;
    return openDatabase(path, version: 1, onCreate: _createTable);
  }

  Future<String> get _dbPath async {
    final databasesPath = await getDatabasesPath();
    return join(databasesPath, 'weight_tracker.db');
  }

  Future<void> _createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        weight REAL NOT NULL,
        date TEXT NOT NULL,
        note TEXT
      )
    ''');
  }

  Future<void> insertWeight({required double weight, required String date, String? note}) async {
    final db = await _getDatabase();
    await db.insert(
      tableName,
      {'weight': weight, 'date': date, 'note': note},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateWeight({required int id, required double weight}) async {
    final db = await _getDatabase();
    await db.update(
      tableName,
      {'weight': weight},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
   Future<int> create({required double weight, String? note}) async {
    final database = await DataBaseService().database;
    return await database.rawInsert(
      '''
      INSERT INTO $tableName(weight, date, note) VALUES(?, ?, ?)
      ''',
      [weight, DateTime.now().millisecondsSinceEpoch, note],
    );
  }


  Future<void> delete(int id) async {
    final db = await _getDatabase();
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  

  Future<List<WeightEntry>> fetchAll() async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> result = await db.query(tableName);
    return result.map((e) => WeightEntry.fromMap(e)).toList();
  }
}

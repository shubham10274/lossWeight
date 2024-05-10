import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:lossy/database/weightEntry.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseService {
  static final dbname = "data.db";
  static final dbversion = 1;

  static final tablename = "activities";

  static final columnid = "columnid";
  static final type = "type";
  static final data = "data";
  static final date = "date";

  // singleton
  DataBaseService._privateConstructor();
  static final DataBaseService instance = DataBaseService._privateConstructor();

  // initialize database

  static Database? database;

  Future<Database?> get db async {
    if (database != null) {
      return database;
    }
    database = await initializeDatabase();
    return database;
  }

  initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbname);
    return await openDatabase(path, version: dbversion, onCreate: createTable);
  }

  createTable(Database db, int version) {
    db.execute('''
      CREATE TABLE $tablename(
      $columnid INTEGER PRIMARY KEY,
      $type TEXT NOT NULL,
      $data REAL NOT NULL,
      $date TEXT NOT NULL
      )
      ''');
    print("Table created");
  }

  Future<int> addActivity(Map<String, dynamic> row) async {
    Database? db = await instance.db;
    return await db!.insert(tablename, row);
  }

  Future<List<Map<String, Object?>>> getActivities(String category) async {
    Database? db = await instance.db;
    if (category == "All") {
      return await db!.rawQuery('SELECT * FROM $tablename');
    } else {
      return await db!.query('$tablename WHERE $type=?',
          whereArgs: [category.toLowerCase()]);
    }
  }
}

import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbname);

    print('Database path: $path'); // Print database path for debugging

    try {
      Database database = await openDatabase(path,
          version: dbversion, onCreate: onCreateDatabase);
      print("Database initialized successfully");
      return database;
    } catch (e) {
      print("Error initializing database: $e");
      rethrow; // Rethrow the exception for better error handling
    }
  }

  void onCreateDatabase(Database db, int version) {
    db.execute('''
    CREATE TABLE (
      $columnid INTEGER PRIMARY KEY,
      $type TEXT NOT NULL,
      $data REAL NOT NULL,
      $date TEXT NOT NULL
    )
  ''');
    print("Table created successfully");
  }

  Future<int> addActivity(Map<String, dynamic> row) async {
    final Database? db = await instance.db;
    return await db!.insert(tablename, row);
  }

  Future<List<Map<String, Object?>>> getActivities(String category) async {
    Database? db = await instance.db;
    if (category == "Weight") {
      print("Fetching all activities...");
      return await db!.rawQuery('SELECT * FROM activities');
    } else {
      print("Fetching activities for category: $category");
      return await db!.query('activities',
          where: 'type = ?', whereArgs: [category.toLowerCase()]);
    }
  }

  Future<int> deleteActivity(int id) async {
    Database? db = await instance.db;
    return await db!.delete(tablename, where: ' $columnid=?', whereArgs: [id]);
  }
}

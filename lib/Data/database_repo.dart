import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../user_data_model.dart';

class DatabaseRepository {
  static final DatabaseRepository instance = DatabaseRepository._init();
  DatabaseRepository._init();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('userlistapp.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
   create table User (
    name text,
    gender text,
    dob text,
    age integer,
    address text,
    picture text
   )''');
  }

// Insert
  Future<void> insert({required User user}) async {
    try {
      final db = await database;
      db.insert('User', user.toMap());
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

// Get
  Future<List<User>> getAllUser() async {
    final db = await instance.database;
    final result = await db.query('User');

    return result.map((json) => User.fromJson(json)).toList();
  }
}

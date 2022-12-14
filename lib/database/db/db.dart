import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  DB._();

  static final DB instance = DB._();

  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await _initDB();
  }

  _initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'stocks.db'),
      onCreate: _onCreate,
      version: 1,
    );
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute(_user);
    await db.execute(_sessionData);
    await db.execute(_stocks);
    await db.execute(_userStockList);
    await db.insert('user', {
      'token': '123456789',
      'name': 'John',
      'email': 'socorro',
      'password': '1234'
    });
    print('Database created');
  }

  final String _user = '''
    CREATE TABLE user (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      email TEXT,
      password TEXT,
      token TEXT
    )
  ''';

  final String _sessionData = '''
    CREATE TABLE sessionData (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      currentToken TEXT
    )
  ''';

  final String _stocks = '''
    CREATE TABLE stocks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      price DOLLAR,
      imagePath TEXT
    )
  ''';

  final String _userStockList = '''
    CREATE TABLE stocksList (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      userId INTEGER,
      longName TEXT,
      shortName TEXT,
      price DOLLAR,
      quantity INTEGER
    )
  ''';
}

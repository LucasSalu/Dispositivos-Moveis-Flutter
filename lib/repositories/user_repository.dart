import 'package:sqflite/sqflite.dart';

import '../database/db/db.dart';

class UserRepository {
  late Database db;

  List<String> ids = [];
  List<String> _names = [];
  List<String> _emails = [];
  List<String> _passwords = [];
  List<String> _tokens = [];

  UserRepository() {
    _initRepository();
  }

  _initRepository() async {
    await _getNames();
    await _getEmails();
    await _getPasswords();
    await _getTokens();
    await _getIds();
  }

  _getIds() async {
    db = await DB.instance.database;
    List<Map<String, Object?>> result = await db.query('user', columns: ['id']);
    ids = result.map((e) => e['id'].toString()).toList();
  }

  _getNames() async {
    db = await DB.instance.database;
    List<String> result =
        await db.query('user', columns: ['name']) as List<String>;
    _names = result;
  }

  _getEmails() async {
    db = await DB.instance.database;
    List<String> result =
        await db.query('user', columns: ['email']) as List<String>;
    _emails = result;
  }

  _getPasswords() async {
    db = await DB.instance.database;
    List<String> result =
        await db.query('user', columns: ['password']) as List<String>;
    _passwords = result;
  }

  _getTokens() async {
    db = await DB.instance.database;
    List<String> result =
        await db.query('user', columns: ['token']) as List<String>;
    _tokens = result;
  }

  List<String> get names => _names;
  List<String> get emails => _emails;
  List<String> get tokens => _tokens;

  Future<void> insertUser(
      String name, String email, String password, String token) async {
    db = await DB.instance.database;
    await db.insert('user',
        {'name': name, 'email': email, 'password': password, 'token': token});
    await _getNames();
    await _getEmails();
    await _getPasswords();
    await _getTokens();
  }
}

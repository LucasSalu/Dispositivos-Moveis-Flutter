import 'package:sqflite/sqflite.dart';

import '../database/db/db.dart';

class UserRepository {
  late Database db;

  List<String> _ids = [];
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
    List<String> result =
        await db.query('user', columns: ['id']) as List<String>;
    _ids = result;
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

  Future<String> getUserToken(String email, String password) async {
    db = await DB.instance.database;
    List<Map<String, dynamic>> result = await db.query('user',
        columns: ['token'],
        where: 'email = ? AND password = ?',
        whereArgs: [email, password]);
    return result.first['token'];
  }

  Future<String> validateToken(String token) async {
    db = await DB.instance.database;
    List<Map<String, dynamic>> result = await db.query('user',
        columns: ['token'], where: 'token = ?', whereArgs: [token]);
    if (result.isEmpty) {
      return '';
    } else {
      return result.first['token'];
    }
  }
}

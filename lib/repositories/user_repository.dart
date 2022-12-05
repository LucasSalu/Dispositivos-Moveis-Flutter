import 'package:atividade_2/bloc/auth/auth_bloc.dart';
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

  getAll() async {
    db = await DB.instance.database;
    List<Map<String, dynamic>> result = await db.query('user');
    return result;
  }

  insertUser(Map<String, dynamic> user) async {
    db = await DB.instance.database;
    await db.insert('user', user);
  }

  _getIds() async {
    db = await DB.instance.database;
    List<Map<String, dynamic>> result = await db.query('user', columns: ['id']);
    _ids = result.map((e) => e['id'].toString()).toList();
  }

  _getNames() async {
    db = await DB.instance.database;
    List<Map<String, dynamic>> result =
        await db.query('user', columns: ['name']);
    _names = result.map((e) => e['name'].toString()).toList();
  }

  _getEmails() async {
    db = await DB.instance.database;
    List<Map<String, dynamic>> result =
        await db.query('user', columns: ['email']);
    _emails = result.map((e) => e['email'].toString()).toList();
  }

  _getPasswords() async {
    db = await DB.instance.database;
    List<Map<String, dynamic>> result =
        await db.query('user', columns: ['password']);
    _passwords = result.map((e) => e['password'].toString()).toList();
  }

  _getTokens() async {
    db = await DB.instance.database;
    List<Map<String, dynamic>> result =
        await db.query('user', columns: ['token']);
    _tokens = result.map((e) => e['token'].toString()).toList();
  }

  List<String> get names => _names;
  List<String> get emails => _emails;
  List<String> get tokens => _tokens;

  Future<void> insertUsers(
      String name, String email, String password, String token) async {
    db = await DB.instance.database;
    await db.insert('user', {
      'name': name,
      'email': email,
      'password': password,
      'token': token
    }).whenComplete(() => print('User inserted'));
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

    print("result: ${result[0]['token']}");
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

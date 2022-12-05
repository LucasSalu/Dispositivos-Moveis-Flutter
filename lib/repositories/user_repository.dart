import 'package:atividade_2/bloc/auth/auth_bloc.dart';
import 'package:atividade_2/bloc/stock/user_stock_bloc.dart';
import 'package:atividade_2/bloc/stock/user_stock_event.dart';
import 'package:atividade_2/repositories/session_data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../database/db/db.dart';

class UserRepository {
  late Database db;

  List<Map<String, dynamic>> _ids = [];
  List<Map<String, dynamic>> _names = [];
  List<Map<String, dynamic>> _emails = [];
  List<Map<String, dynamic>> _passwords = [];
  List<Map<String, dynamic>> _tokens = [];

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
    _ids = result;
  }

  _getNames() async {
    db = await DB.instance.database;
    List<Map<String, dynamic>> result =
        await db.query('user', columns: ['name']);
    _names = result;
  }

  _getEmails() async {
    db = await DB.instance.database;
    List<Map<String, dynamic>> result =
        await db.query('user', columns: ['email']);
    _emails = result;
  }

  _getPasswords() async {
    db = await DB.instance.database;
    List<Map<String, dynamic>> result =
        await db.query('user', columns: ['password']);
    _passwords = result;
  }

  _getTokens() async {
    db = await DB.instance.database;
    List<Map<String, dynamic>> result =
        await db.query('user', columns: ['token']);
    _tokens = result;
  }

  List<Map<String, dynamic>> get names => _names;
  List<Map<String, dynamic>> get emails => _emails;
  List<Map<String, dynamic>> get tokens => _tokens;

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

    if (result.isNotEmpty) {
      return result.first['token'];
    } else {
      return '';
    }
  }

  getUserNameByEmail(String email) async {
    db = await DB.instance.database;
    List<Map<String, dynamic>> result = await db.query('user',
        columns: ['name'], where: 'email = ?', whereArgs: [email]);

    if (result.isNotEmpty) {
      return result.first['name'];
    } else {
      return '';
    }
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

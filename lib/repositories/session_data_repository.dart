import 'package:sqflite/sqflite.dart';

import '../database/db/db.dart';

class SessionDataRepository {
  late Database db;

  String _currentToken = '';

  SessionDataRepository() {
    _initRepository();
  }

  _initRepository() async {
    await getCurrentToken();
  }

  getCurrentToken() async {
    db = await DB.instance.database;
    List<Map<String, Object?>> result = await db.query('user');
    _currentToken = result.first['token'].toString();
  }

  String get currentToken => _currentToken;

  Future<String> validateSessionToken(String token) async {
    db = await DB.instance.database;
    List<Map<String, Object?>> result = await db.query('user');
    if (result.first['currentToken'].toString() == token) {
      return token;
    } else {
      return '';
    }
  }

  Future<void> updateCurrentToken(String token) async {
    db = await DB.instance.database;
    await db.update('_sessionData', {'currentToken': token});
    await getCurrentToken();
  }

  Future<void> deleteCurrentToken() async {
    db = await DB.instance.database;
    await db.delete('sessionData',
        where: 'currentToken = ?', whereArgs: [_currentToken]);
    await getCurrentToken();
  }
}

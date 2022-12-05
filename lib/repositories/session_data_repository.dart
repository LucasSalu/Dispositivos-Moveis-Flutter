import 'package:sqflite/sqflite.dart';

import '../database/db/db.dart';

class CurrentSessionRepository {
  late Database db;

  String _currentToken = '';

  CurrentSessionRepository() {
    _initRepository();
  }

  _initRepository() async {
    await _getCurrentToken();
  }

  _getCurrentToken() async {
    db = await DB.instance.database;
    List<Map<String, Object?>> result = await db.query('user');
    _currentToken = result.first['token'].toString();
  }

  String get currentToken => _currentToken;

  Future<void> updateCurrentToken(String token) async {
    db = await DB.instance.database;
    await db.update('_sessionData', {'currentToken': token});
    await _getCurrentToken();
  }

  Future<void> deleteCurrentToken() async {
    db = await DB.instance.database;
    await _getCurrentToken();
    await db.delete('sessionData',
        where: 'currentToken = ?', whereArgs: [_currentToken]);
    await _getCurrentToken();
  }
}

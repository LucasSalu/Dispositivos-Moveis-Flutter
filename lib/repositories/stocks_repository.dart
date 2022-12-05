import 'package:sqflite/sqflite.dart';

import '../database/db/db.dart';

class StocksRepository {
  late Database db;

  List<String> _ids = [];
  List<String> _names = [];
  List<String> _prices = [];
  List<String> _imagePaths = [];

  StocksRepository() {
    _initRepository();
  }

  _initRepository() async {
    await _getIds();
    await _getNames();
    await _getPrices();
    await _getImagePaths();
  }

  _getIds() async {
    db = await DB.instance.database;
    List<String> result =
        await db.query('stock', columns: ['id']) as List<String>;
    _ids = result;
  }

  _getNames() async {
    db = await DB.instance.database;
    List<String> result =
        await db.query('stock', columns: ['name']) as List<String>;
    _names = result;
  }

  _getPrices() async {
    db = await DB.instance.database;
    List<String> result =
        await db.query('stock', columns: ['price']) as List<String>;
    _prices = result;
  }

  _getImagePaths() async {
    db = await DB.instance.database;
    List<String> result =
        await db.query('stock', columns: ['imagePath']) as List<String>;
    _imagePaths = result;
  }

  List<String> get names => _names;
  List<String> get prices => _prices;
  List<String> get imagePaths => _imagePaths;
}

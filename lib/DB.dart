import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "vegas";
  static final _databaseVersion = 1;
  static final USER_TABLE = 'birr';
  static final TABLE = 'birr';
  static final TABLE1 = 'admin';
  static final ID = 'id';
  static final NAME = 'name';
  static final AMOUNT = 'amount';
  static final OVER = 'over';
  static final PHONE = 'phone_number';
  static final BALE = 'bale';
  static final BIRR = 'birr';
  static final HOUSE = 'house';
  static final AGENT = 'agent';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  Future<bool> isDBnull() async {
    if (_database == null) {
      return true;
    }
    return false;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  //
  //

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    String query =
        "CREATE TABLE $TABLE  ($ID int PRIMARY KEY, $NAME TEXT, $AMOUNT int, $OVER int, $BALE int, $PHONE TEXT)";
    await db.execute(query);
    String query1 =
        "CREATE TABLE $TABLE1  ($ID int PRIMARY KEY, $NAME TEXT, $AMOUNT int, $OVER int, $BALE int, $PHONE TEXT, $BIRR int, $HOUSE int, $AGENT TEXT)";
    await db.execute(query1);
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    await db.insert(TABLE, row);
    return 1;
  }

  Future<int> insert1(Map<String, dynamic> row) async {
    Database db = await instance.database;
    await db.insert(TABLE1, row);
    return 1;
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  //  this is not the result of the war
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(TABLE);
  }

  Future<List<Map<String, dynamic>>> queryAllRows1() async {
    Database db = await instance.database;
    return await db.query(TABLE1);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $TABLE '));
  }
   Future<int> queryRowCount1() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $TABLE1 '));
  }

  Future<List<Map<String, dynamic>>> queryAmount() async {
    Database db = await instance.database;
    return await db
        .rawQuery('SELECT COUNT(amount) FROM $TABLE WHERE $NAME = "Admin"');
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[ID];
    return await db.update(TABLE, row, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> update1(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[ID];
    return await db.update(TABLE1, row, where: '$ID = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;

    return await db.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> delete1(int id) async {
    Database db = await instance.database;

    return await db.delete(TABLE1, where: '$ID = ?', whereArgs: [id]);
  }
}

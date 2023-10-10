import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:developer' as developer;

import 'model/dataServer.dart';

class DBProvider {
  DBProvider._privateConstructor();

  static final DBProvider instance = DBProvider._privateConstructor();
  static const _dbName = "pscm-data.db";
  static const _dbVersion = 2;
  static Database? _database;
  static const nullID = -1;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    await initDB();
    if (_database == null) {
    }
    return _database!;
  }

  initDB() async {
    if (_database!=null && _database!.isOpen) {
      _database!.close();
    }
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    _database = await openDatabase(path, version: _dbVersion,
        onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    var batch = db.batch();
    if (oldVersion == 1) {
      await _upgradeToVer2(batch);
    }
    else if (oldVersion == 2) {

    }
    await batch.commit();
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    var batch = db.batch();

    developer.log(
        'FutureOr<void> _onCreate(Database db, int version)');
    _createTableServerList(batch);
    await batch.commit();
  }

  //model create
  Future<void> _createTableServerList(Batch batch) async {
    batch.execute('''CREATE TABLE server_connect (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      description TEXT,
      token TEXT,
      username TEXT,
      password TEXT,
      server TEXT,
      inactive INTEGER
    )''');
  }

  Future<void> _upgradeToVer2(Batch batch) async {
    developer.log(
        'Future<void> _upgradeToVer2(Batch batch) async');
    batch.execute('''ALTER TABLE TABLE ServerInfo
      RENAME TO server_connect;
      ''');
  }

  Future<List<ServerInfo>> fetchAllServers() async {
    Database db = await database;
    developer.log(
        'Future<List<ServerInfo>> fetchAllServers() async');
    final List<Map<String, dynamic>> maps = await db.query('server_connect');
    return List.generate(maps.length, (i) {
      return ServerInfo(
        id:           maps[i]['id'],
        name:         maps[i]['name'],
        descr:        maps[i]['description'],
        token:        maps[i]['token'],
        userName:     maps[i]['username'],
        userPassword: maps[i]['password'],
        serverAddress: maps[i]['server'],
        isActive:     maps[i]['inactive']==1 ? false : true
      );
    });
  }

  Future<void> updateTokenAccessServer(int idServer, String token) async {
    final db = await database;
    await db.update(
      'server_connect',
      { 'token' : token },
      where: 'id = ?',
      whereArgs: [idServer],
    );
  }

  Future<bool> updateServerInfo(ServerInfo srvInfo) async {
    final db = await database;
    bool result = false;
    if (srvInfo.id == nullID) {
      //Adding new server
      int insertId = await db.insert('server_connect',
          srvInfo.toMapDB(),
          conflictAlgorithm: ConflictAlgorithm.rollback);
      if (insertId!=0) {
        srvInfo.id = insertId;
        result = true;
      }
    }
    else {
      //Update existing server
      int countUpdate = await db.update(
        'server_connect',
        srvInfo.toMapDB(),
        where: 'id = ?',
        whereArgs: [srvInfo.id],
      );
      result = countUpdate>0 ? true : false;
    }
    return result;
  }

  Future<bool> deleteServerInfo(int id) async {
    final db = await database;
    bool result = false;
    if (id != nullID) {
      int countUpdate = await db.delete(
        'server_connect',
        where: 'id = ?',
        whereArgs: [id],
      );
      return countUpdate!=0 ? true : false;
    }
    return false;
  }

}
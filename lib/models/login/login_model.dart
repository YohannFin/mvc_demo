import 'package:flutter/foundation.dart';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class LoginModel extends ChangeNotifier {
  LoginModel();

  LoginModel.instance() {
    
  }
  static Database _db;

  Future<Database> get db async {
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "flybank.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
    "CREATE TABLE User(id INTEGER PRIMARY KEY, username TEXT, password TEXT)");
    print("Created tables");
  }

  Future<String> insertUserDefault() async
  {
    String usernamedefault = 'yohann';
    String passworddefault = 'test';
    var result = await getUser("yohann", "test");
    var dbClient = await db;
    if (result == false)
      dbClient.rawInsert('INSERT INTO User(username, password) VALUES(?, ?)', [usernamedefault, passworddefault]);
    return "ok";
  }

  Future<String> insertUser() async
  {
    String usernamedefault = 'yohann';
    String passworddefault = 'test';
    var result = await getUser("yohann", "test");
    var dbClient = await db;
    if (result == false)
      dbClient.rawInsert('INSERT INTO User(username, password) VALUES(?, ?)', [usernamedefault, passworddefault]);
    return "ok";
  }

  Future<bool> getUser(username, password) async {
    var dbClient = await db;
    //var res = await dbClient.rawQuery("SELECT * FROM User WHERE username = '$username' and password = '$password'");
    var res = await dbClient.query("User", where: 'username = ? and password = ?', whereArgs: [username.toString(), password.toString()]);
    return res.length > 0? true: false;
  }
}

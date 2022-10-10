import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'; //تخص join

class SqlDb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    //تحديد مسار الداتا بيز1..
    String databasepath = await getDatabasesPath();
    String path = join(
      databasepath,
      'todoApp.db',
    );
    Database mydb = await openDatabase(path,
        onCreate: _Oncreate, version: 1, onUpgrade: _onupdate);
    return mydb;
  }

  _Oncreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)');
    print(
        "=============================  Create Table Done !!  ===========================");
  }

  _onupdate(Database db, int oldversion, newversion) {
    print(
        "==================== Database update Sucssfuly ====================================");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> respoinse = await mydb!.rawQuery(sql);
    return respoinse;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int respoinse = await mydb!.rawInsert(sql);
    return respoinse;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int respoinse = await mydb!.rawUpdate(sql);
    return respoinse;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int respoinse = await mydb!.rawDelete(sql);
    return respoinse;
  }

  mydeletedatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'emad.db');
    await deleteDatabase(path);
    print("Database Delete Sucssfuly");
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp_todo/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../modules/archive_screen/archive_screen.dart';
import '../../modules/done_screen/done_screen.dart';
import '../../modules/tasks_screen/tasks_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  bool isbottomsheetshown = false;
  IconData Flotingbutoomicon = Icons.edit;
  IconData fabicon = Icons.edit;
  Color colofloating = Colors.indigo;
  int btnnavbar = 0;
  List donelist = [];
  List taskslist = [];
  List arcivelist = [];
  List<Widget> screens = [
    TasksScreen(),
    donescreen(),
    arcivescreen(),
  ];
  List<String> titls = [
    " مهامي",
    "تم انجازها",
    "أرشيف",
  ];

  /********************* قاعدة البيانات*********************** */
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

  /******************* إنشاء الجدول داخل قاعدة البيانات ************************** */
  _Oncreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)');
    print(
        "=============================  Create Table Done !!  ===========================");
  }

  /******************* تحديث قاعدة البيانات ************************** */
  _onupdate(Database db, int oldversion, newversion) {
    print(
        "==================== Database update Sucssfuly ====================================");
  }

  /****************  قراءة البيانات داخل قاعدة البيانات  *************** */
  readData(String sql) async {
    Database? mydb = await db;
    List<Map> respoinse = await mydb!.rawQuery(sql);

    return respoinse;
  }

  Future readDataview() async {
    taskslist = [];
    donelist = [];
    arcivelist = [];

    await readData("SELECT * FROM tasks Where status='NEW'").then((value) {
      taskslist.addAll(value);
    });
    await readData("SELECT * FROM tasks Where status='DONE'").then((value) {
      donelist.addAll(value);
    });
    await readData("SELECT * FROM tasks Where status='ARCIVE'").then((value) {
      arcivelist.addAll(value);
    });

    emit(AppReadDatabaseState());
  }

  /****************  قراءة البيانات داخل قاعدة البيانات  *************** */

  /****************  إضافة البيانات داخل قاعدة البيانات  *************** */
  insertData(
    String title,
    String time,
    String date,
  ) async {
    Database? mydb = await db;
    var respoinse = await mydb!
        .rawInsert(
            'INSERT INTO tasks (title,time,date,status) VALUES("${title}","${time}","${date}","NEW")')
        .then(((value) {
      readDataview();
      emit(AppInsertedState());
    }));

    return respoinse;
  }

/****************  إضافة البيانات داخل قاعدة البيانات  *************** */
/****************  تحديث البيانات داخل قاعدة البيانات  *************** */
  updateData(String stutus, int id) async {
    Database? mydb = await db;
    int respoinse = await mydb!.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?', [stutus.toString(), id]);
    readDataview();
    return respoinse;
  }

/****************  تحديث البيانات داخل قاعدة البيانات  *************** */
/****************  حذف البيانات داخل قاعدة البيانات  *************** */
  deleteData(int id) async {
    Database? mydb = await db;

    await mydb!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]);
    readDataview();
  }
/****************  حذف البيانات داخل قاعدة البيانات  *************** */

/****************  حذف قاعدة البيانات  *************** */
  mydeletedatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'emad.db');
    await deleteDatabase(path);
    print("Database Delete Sucssfuly");
  }

/****************  حذف قاعدة البيانات  *************** */
  /**********************  التبديل بين الصفحات بأستخدام الاندكس******************** */
  void ChangeIndex(int index) {
    btnnavbar = index;
    emit(AppChangeBottomNavBarState());
  }

  /**********************  التبديل بين الصفحات بأستخدام الاندكس******************** */
/******************** تغيير الالوان والعرض والاغلاق الخاص بزر النافذة السفلية****************** */
  void changeBottomSHeetState(
      {required bool show, required IconData icon, required Color Colorreq}) {
    isbottomsheetshown = show;
    fabicon = icon;
    colofloating = Colorreq;
    emit(BottomSheetState());
  }
  /******************** تغيير الالوان والعرض والاغلاق الخاص بزر النافذة السفلية****************** */
}
//تخص join

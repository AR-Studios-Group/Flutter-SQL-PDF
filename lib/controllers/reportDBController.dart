import 'package:database_pdf/models/report.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ReportDBController extends GetxController {
  late Database db;
  static const tableName = 'Reports';
  var reports = <Report>[].obs;

  Future<void> open() async {
    try {
      String path = join(await getDatabasesPath(), 'reportsDB.db');
      db = await openDatabase(path, version: 1,
          onCreate: (Database _db, int _version) async {
        _db.execute('''
        CREATE TABLE $tableName (
          create_date TEXT PRIMARY KEY, 
          device_name TEXT,
          userId TEXT, 
          phoneId TEXT, 
          alias TEXT, 
          installation_result TEXT
        )
      ''');
      });
    } catch (err) {
      print(err);
    }
  }

  Future<void> close() async {
    db.close();
  }

  Future<void> readAll() async {
    try {
      reports.clear();
      var results = await db.rawQuery('SELECT * FROM $tableName');

      if (results.isNotEmpty) {
        for (var r in results) {
          var date = r['create_date'].toString();
          var deviceName = r['device_name'].toString();
          var userID = r['userId'].toString();
          var phoneID = r['phoneID'].toString();
          var alias = r['alias'].toString();
          var installationResult = r['installation_result'].toString();

          reports.add(Report(
              date, deviceName, userID, phoneID, alias, installationResult));
        }
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> add(Report report) async {
    try {
      await db.insert(tableName, report.toMap());
      reports.insert(0, report);
    } catch (err) {
      print(err);
    }
  }

  Future<void> delete(Report report) async {
    try {
      await db.delete(tableName,
          where: 'create_date = ?', whereArgs: [report.create_date]);
      reports.remove(report);
    } catch (err) {
      print(err);
    }
  }

  @override
  void onInit() async {
    open().then((v) => readAll());
    super.onInit();
  }

  @override
  void onClose() async {
    close();
    super.onClose();
  }
}

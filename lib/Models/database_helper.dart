import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:attendance_trackerr/Models/attendance_data.dart';
import 'dart:io';

class AttendanceDatabaseHelper {
  static final _databaseHelper = AttendanceDatabaseHelper._internal();

  AttendanceDatabaseHelper._internal();

  factory AttendanceDatabaseHelper() {
    return _databaseHelper;
  }

  static const String _databaseName = "attendance.db";
  static const int _databaseVersion = 1;
  static const String _tableName = 'AttendanceTable';

  static const String _serial = 'serial';
  static const String _course = 'course_name';
  static const String _date = 'date';
  static const String _status = 'status';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _createDb);
  }

  Future _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $_tableName ($_serial INTEGER PRIMARY KEY AUTOINCREMENT, $_course TEXT, $_date TEXT, $_status INTEGER)');
  }

  Future<List<Map<String, dynamic>>> getCourseMapList() async {
    Database db = await this.database;
    var results = await db.query(_tableName, orderBy: '$_course ASC');
    return results;
  }

  Future<int> insertAttendance(AttendanceData attendance) async {
    Database db = await this.database;
    var results = await db.insert('AttendanceTable', attendance.toMap());
    return results;
  }

  Future<int> updateAttendance(AttendanceData attendance) async {
    Database db = await this.database;
    var results = await db.update('AttendanceTable', attendance.toMap(),
        where: '$_serial = ?', whereArgs: [attendance.serial]);
    return results;
  }

  Future<int> deleteCourse(AttendanceData attendance) async {
    var db = await this.database;
    int results = await db.delete(
      'AttendanceTable',
      where: '$_course = ?',
      whereArgs: [attendance.currrentCourseName],
    );
    return results;
  }

  Future<int> deleteAttendance(AttendanceData attendance) async {
    var db = await this.database;
    int results = await db.delete(
      'AttendanceTable',
      where: '$_course = ?',
      whereArgs: [attendance.currrentCourseName],
    );
    return results;
  }

  Future<int> getClasses(String name, int n) async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('''
    SELECT COUNT(*) AS count
    FROM $_tableName
    WHERE course_name = '$name' AND status = $n
    ''');

    int? result = Sqflite.firstIntValue(x);
    int output = result ?? 0;
    return output;
  }

  Future<int> getCourseCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('''
    SELECT COUNT(DISTINCT course_name) AS count 
    FROM $_tableName
  ''');

    int? result = Sqflite.firstIntValue(x);
    int output = result ?? 0;
    return output;
  }

  Future<List<AttendanceData>> getCourseList() async {
    var courseMapList = await getCourseMapList();
    int count = courseMapList.length;

    List<AttendanceData> courseList = [];

    for (int i = 0; i < count; i++) {
      if (courseMapList[i][_status] == -1) {
        courseList.add(AttendanceData.fromMapObject(courseMapList[i]));
      }
    }

    return courseList;
  }

  Future<List<AttendanceData>> getAttendanceList(String course) async {
    var attendanceMapList = await getCourseMapList();
    int count = attendanceMapList.length;
    List<AttendanceData> attendanceList = [];
    for (int i = 0; i < count; i++) {
      if (attendanceMapList[i][_course] == course &&
          (attendanceMapList[i][_status] == 0 ||
              attendanceMapList[i][_status] == 1)) {
        attendanceList.add(AttendanceData.fromMapObject(attendanceMapList[i]));
      }
    }
    return attendanceList;
  }

  Future<List<AttendanceData>> getStatus(String thisCourse) async {
    var courseMapList = await getCourseMapList();
    int count = courseMapList.length;
    List<AttendanceData> statusList = [];

    for (int i = 0; i < count; i++) {
      if (courseMapList[i][_status] != -1 &&
          courseMapList[i][_course] == thisCourse) {
        statusList.add(AttendanceData.fromMapObject(courseMapList[i]));
      }
    }
    return statusList;
  }
}

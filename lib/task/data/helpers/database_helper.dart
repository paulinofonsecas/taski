import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DatabaseHelper {
  static Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        isCompleted BOOLEAN DEFAULT 0,
        createdAt DATETIME NOT NULL,
        updatedAt DATETIME NOT NULL,
        completedAt DATETIME
      )
    ''');
  }

  static Future<Database> initDatabase() async {
    late String path;

    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
      path = 'my_web_web.db';
      return databaseFactoryFfiWeb.openDatabase(
        path,
        options: OpenDatabaseOptions(version: 6, onCreate: _createDb),
      );
    } else {
      final databasesPath = await getDatabasesPath();
      path = join(databasesPath, 'taski10.db');
    }

    return openDatabase(
      path,
      version: 6,
      onCreate: _createDb,
    );
  }
}

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'taski10.db');

    return openDatabase(
      path,
      version: 6,
      onCreate: _createDb,
    );
  }

  static Future<Database> initTestDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'taski10.db');

    return openDatabase(
      path,
      version: 6,
      onCreate: _createDb,
    );
  }

}

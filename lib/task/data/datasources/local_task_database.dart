import 'package:either_dart/either.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taski/erros/failure.dart';
import 'package:taski/task/data/datasources/i_task_datasource.dart';
import 'package:taski/task/data/models/task_model.dart';

class LocalTaskDatasource implements ITaskDatasource {
  LocalTaskDatasource(this._database);

  final Database _database;

  @override
  Future<Either<Failure, void>> createTask(TaskModel task) async {
    final db = _database;

    await db.insert(
      'tasks',
      {
        'title': task.title,
        'description': task.description,
        'isCompleted': task.isCompleted ? 1 : 0,
        'createdAt': task.createdAt.toIso8601String(),
        'updatedAt': task.updatedAt.toIso8601String(),
        'completedAt': task.completedAt?.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> deleteTask(int index) async {
    final db = _database;

    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [index],
    );

    return const Right(null);
  }

  @override
  Future<Either<Failure, List<TaskModel>>> fetchTasks(
    int page,
    int limit,
  ) async {
    final db = _database;

    final result = await db.query(
      'tasks',
      limit: limit,
      offset: page * limit,
      orderBy: 'updatedAt DESC',
      where: 'isCompleted = 0',
    );

    return Right(result.map(TaskModel.fromMap).toList());
  }

  @override
  Future<Either<Failure, void>> toggleTask(TaskModel task) async {
    final db = _database;

    await db.update(
      'tasks',
      {
        'isCompleted': task.isCompleted ? 0 : 1,
        'completedAt': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [task.id],
    );

    return const Right(null);
  }

  @override
  Future<Either<Failure, List<TaskModel>>> fetchCompletedTasks(
    int page,
    int limit,
  ) async {
    final db = _database;

    final result = await db.query(
      'tasks',
      limit: limit,
      offset: page * limit,
      orderBy: 'completedAt DESC',
      where: 'isCompleted = 1',
    );

    return Right(result.map(TaskModel.fromMap).toList());
  }
}

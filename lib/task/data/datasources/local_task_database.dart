import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taski/core/error/failure.dart';
import 'package:taski/task/data/datasources/i_task_datasource.dart';
import 'package:taski/task/data/models/task_model.dart';
import 'package:taski/task/domain/entities/task.dart';

class LocalTaskDatasource implements ITaskDatasource {
  LocalTaskDatasource(this._database);

  final Database _database;

  @override
  Future<Either<Failure, void>> createTask(TaskModel task) async {
    try {
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
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(int index) async {
    try {
      final db = _database;

      await db.delete(
        'tasks',
        where: 'id = ?',
        whereArgs: [index],
      );

      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TaskModel>>> fetchTasks(
    int page,
    int limit,
  ) async {
    try {
      final db = _database;

      final result = await db.query(
        'tasks',
        limit: limit,
        offset: page * limit,
        orderBy: 'updatedAt DESC',
        where: 'isCompleted = 0',
      );

      return Right(result.map(TaskModel.fromMap).toList());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleTask(TaskModel task) async {
    try {
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
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TaskModel>>> fetchCompletedTasks(
    int page,
    int limit,
  ) async {
    try {
      final db = _database;

      final result = await db.query(
        'tasks',
        limit: limit,
        offset: page * limit,
        orderBy: 'completedAt DESC',
        where: 'isCompleted = 1',
      );

      return Right(result.map(TaskModel.fromMap).toList());
    } catch (e) {
      log(e.toString());
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Task>>> searchTasks(String text) async {
    try {
      final db = _database;

      final result = await db.query(
        'tasks',
        where: 'title LIKE ?',
        whereArgs: ['%$text%'],
      );

      return Right(result.map(TaskModel.fromMap).toList());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAllCompletedTasks() async {
    try {
      final db = _database;

      // delete all completed tasks
      await db.delete(
        'tasks',
        where: 'isCompleted = 1',
      );

      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taski/task/data/datasources/local_task_database.dart';
import 'package:taski/task/data/models/task_model.dart';

class MockDatabaseHelper extends Mock implements Database {}

void main() {
  final db = MockDatabaseHelper();

  group('LocalTaskDatabase', () {
    test('can be instantiated', () {
      expect(LocalTaskDatasource(db), isNotNull);
    });

    test('can fetch tasks', () async {
      final datasource = LocalTaskDatasource(db);
      when(
        () => db.query(
          'tasks',
          limit: 10,
          offset: 0,
          orderBy: 'updatedAt DESC',
          where: 'isCompleted = 0',
        ),
      ).thenAnswer(
        (_) async => [
          TaskModel.create(title: 'Teste', description: 'Note').toMap(),
          TaskModel.create(title: 'Teste2', description: 'Note2').toMap(),
          TaskModel.create(title: 'Teste3', description: 'Note3').toMap(),
          TaskModel.create(title: 'Teste4', description: 'Note4').toMap(),
        ],
      );

      final result = await datasource.fetchTasks(0, 10);

      expect(result.isRight, true);
      expect(result.right.first.title, 'Teste');
    });

    test('can create task', () async {
      final datasource = LocalTaskDatasource(db);
      final task = TaskModel.create(title: 'Teste', description: 'Note');
      when(
        () => db.insert(
          'tasks',
          any(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        ),
      ).thenAnswer((_) async => 1);

      final result = await datasource.createTask(task);

      expect(result.isRight, true);
    });

    test('can toggle task', () async {
      final datasource = LocalTaskDatasource(db);

      final task = TaskModel.create(title: 'Teste', description: 'Note');

      when(
        () => db.update(
          'tasks',
          any(),
          where: any(named: 'where'),
          whereArgs: any(named: 'whereArgs'),
        ),
      ).thenAnswer((_) async => 1);

      final result = await datasource.toggleTask(task);

      expect(result.isRight, true);
    });

    test('can delete task', () async {
      final datasource = LocalTaskDatasource(db);

      final task = TaskModel.create(title: 'Teste', description: 'Note');

      when(
        () => db.delete(
          'tasks',
          where: any(named: 'where'),
          whereArgs: any(named: 'whereArgs'),
        ),
      ).thenAnswer((_) async => 1);

      final result = await datasource.deleteTask(task.id);

      expect(result.isRight, true);
    });

    test('can delete all completed tasks', () async {
      final datasource = LocalTaskDatasource(db);

      when(
        () => db.delete(
          'tasks',
          where: any(named: 'where'),
          whereArgs: any(named: 'whereArgs'),
        ),
      ).thenAnswer((_) async => 1);

      final result = await datasource.deleteAllCompletedTasks();

      expect(result.isRight, true);
    });
  });
}

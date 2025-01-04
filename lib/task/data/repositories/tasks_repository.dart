import 'package:either_dart/src/either.dart';
import 'package:taski/erros/failure.dart';
import 'package:taski/task/data/datasources/i_task_datasource.dart';
import 'package:taski/task/data/models/task_model.dart';
import 'package:taski/task/domain/entities/task.dart';
import 'package:taski/task/domain/repositories/i_tasks_repository.dart';

class TasksRepository implements ITasksRepository {
  TasksRepository(this._localDatasource);

  final ITaskDatasource _localDatasource;

  @override
  Future<Either<Failure, void>> createTask(Task task) {
    return _localDatasource.createTask(TaskModel.fromTask(task));
  }

  @override
  Future<Either<Failure, void>> deleteTask(int id) {
    return _localDatasource.deleteTask(id);
  }

  @override
  Future<Either<Failure, List<Task>>> fetchTasks(int page, int limit) async {
    return _localDatasource.fetchTasks(page, limit);
  }

  @override
  Future<Either<Failure, void>> toggleTask(Task task) {
    return _localDatasource.toggleTask(TaskModel.fromTask(task));
  }

  @override
  Future<Either<Failure, List<Task>>> fetchCompletedTasks(int page, int limit) {
    return _localDatasource.fetchCompletedTasks(page, limit);
  }
}

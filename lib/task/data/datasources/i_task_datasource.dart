import 'package:either_dart/either.dart';
import 'package:taski/erros/failure.dart';
import 'package:taski/task/data/models/task_model.dart';

abstract class ITaskDatasource {
  Future<Either<Failure, void>> createTask(TaskModel task);
  Future<Either<Failure, void>> toggleTask(TaskModel task);
  Future<Either<Failure, void>> deleteTask(int id);
  Future<Either<Failure, List<TaskModel>>> fetchTasks(int page, int limit);
  Future<Either<Failure, List<TaskModel>>> fetchCompletedTasks(
    int page,
    int limit,
  );
}
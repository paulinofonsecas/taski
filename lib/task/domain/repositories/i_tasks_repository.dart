import 'package:either_dart/either.dart';
import 'package:taski/erros/failure.dart';
import 'package:taski/task/domain/entities/task.dart';

abstract class ITasksRepository {
  Future<Either<Failure, void>> createTask(Task task);
  Future<Either<Failure, void>> toggleTask(int id);
  Future<Either<Failure, void>> deleteTask(int id);
  Future<Either<Failure, List<Task>>> fetchTasks(int page, int limit);
}

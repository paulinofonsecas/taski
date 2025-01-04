import 'package:either_dart/either.dart';
import 'package:taski/core/error/failure.dart';
import 'package:taski/task/domain/entities/task.dart';

abstract class ITasksRepository {
  Future<Either<Failure, void>> createTask(Task task);
  Future<Either<Failure, void>> toggleTask(Task task);
  Future<Either<Failure, void>> deleteTask(int id);
  Future<Either<Failure, void>> deleteAllCompletedTasks();
  Future<Either<Failure, List<Task>>> searchTasks(String text);
  Future<Either<Failure, List<Task>>> fetchTasks(int page, int limit);
  Future<Either<Failure, List<Task>>> fetchCompletedTasks(int page, int limit);
}

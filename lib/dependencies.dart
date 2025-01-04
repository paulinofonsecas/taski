import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taski/task/data/datasources/i_task_datasource.dart';
import 'package:taski/task/data/datasources/local_task_database.dart';
import 'package:taski/task/data/helpers/database_helper.dart';
import 'package:taski/task/data/repositories/tasks_repository.dart';
import 'package:taski/task/domain/repositories/i_tasks_repository.dart';
import 'package:taski/task/presentation/home/view_models/home_viewmodel.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  final db = await DatabaseHelper.initDatabase();

  getIt
    ..registerSingleton<Database>(db)
    ..registerSingleton<ITaskDatasource>(LocalTaskDatasource(getIt()))
    ..registerSingleton<ITasksRepository>(TasksRepository(getIt()))

    // viewmodels
    ..registerLazySingleton(() => HomeViewmodel(getIt()));
}

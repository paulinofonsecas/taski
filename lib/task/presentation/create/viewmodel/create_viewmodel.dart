import 'package:flutter/material.dart';
import 'package:taski/task/data/models/task_model.dart';
import 'package:taski/task/domain/repositories/i_tasks_repository.dart';
import 'package:taski/task/presentation/todo/view_models/todo_viewmodel.dart';

class CreateViewmodel extends ChangeNotifier {
  CreateViewmodel({
    required ITasksRepository tasksRepository,
    required TodoViewModel todoViewmodel,
  })  : _tasksRepository = tasksRepository,
        _todoViewmodel = todoViewmodel;

  final ITasksRepository _tasksRepository;
  final TodoViewModel _todoViewmodel;

  // controle de erro
  bool _hasError = false;

  bool get hasError => _hasError;

  set hasError(bool value) {
    _hasError = value;
    notifyListeners();
  }

  Future<void> createTask(String todo, String note) async {
    final task = TaskModel.create(
      title: todo,
      description: note,
    );

    final result = await _tasksRepository.createTask(task);

    if (result.isLeft) {
      hasError = true;
    }

    await _todoViewmodel.reloadTasks();
  }
}

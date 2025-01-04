import 'package:flutter/material.dart';
import 'package:taski/erros/failure.dart';
import 'package:taski/task/domain/entities/task.dart';
import 'package:taski/task/domain/repositories/i_tasks_repository.dart';

class SearchViewmodel extends ChangeNotifier {
  SearchViewmodel(this._tasksRepository);

  final ITasksRepository _tasksRepository;

  String _searchText = '';
  bool _isLoading = false;
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  bool get isLoading => _isLoading;

  String get searchText => _searchText;

  Future<void> searchTasks(String text) async {
    _searchText = text;
    _isLoading = true;

    final newTasks = await _tasksRepository.searchTasks(text);

    if (newTasks.isLeft) {
      print(newTasks.left.message);
    }

    _tasks.clear();
    _tasks.addAll(newTasks.right);

    _isLoading = false;

    notifyListeners();
  }

  Future<void> toggleTask(Task task) async {
    final result = await _tasksRepository.toggleTask(task);

    if (result.isLeft) {
      showError(result.left);
    }

    return reloadTasks();
  }

  void showError(Failure failure) {}

  Future<void> reloadTasks() async {
    _tasks.clear();

    return searchTasks(_searchText);
  }
}

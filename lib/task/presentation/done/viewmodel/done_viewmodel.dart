import 'package:flutter/material.dart';
import 'package:taski/erros/failure.dart';
import 'package:taski/task/domain/entities/task.dart';
import 'package:taski/task/domain/repositories/i_tasks_repository.dart';
import 'package:taski/task/presentation/home/view_models/home_viewmodel.dart';

class DoneViewmodel extends ChangeNotifier {
  DoneViewmodel(this._tasksRepository, this.homeViewModel);

  final HomeViewmodel homeViewModel;
  final ITasksRepository _tasksRepository;

  int _page = 0;
  bool _isLoading = true;
  bool _isLoadCompleted = false;
  final int _limit = 15;
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  bool get isLoading => _isLoading;

  Future<void> loadMoreTasks() async {
    if (_isLoadCompleted) return;

    _isLoading = true;
    if (_page != 0) {
      notifyListeners();
    }

    final newTasks = await _tasksRepository.fetchCompletedTasks(_page, _limit);

    if (newTasks.isLeft) {
      print(newTasks.left.message);
    }

    if (newTasks.right.isEmpty || newTasks.right.length < _limit) {
      _isLoadCompleted = true;
    }

    _tasks.addAll(newTasks.right);
    _page += 1;

    _isLoading = false;

    notifyListeners();
  }

  Future<void> toggleTask(Task task) async {
    final result = await _tasksRepository.toggleTask(task);

    if (result.isLeft) {
      showError(result.left);
    }
    await homeViewModel.reloadTasks();
    return reloadTasks();
  }

  void showError(Failure failure) {}

  Future<void> reloadTasks() async {
    _page = 0;
    _isLoadCompleted = false;
    _tasks.clear();

    return loadMoreTasks();
  }
}
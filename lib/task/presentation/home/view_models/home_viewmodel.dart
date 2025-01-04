import 'package:flutter/foundation.dart';
import 'package:taski/erros/failure.dart';
import 'package:taski/task/domain/entities/task.dart';
import 'package:taski/task/domain/repositories/i_tasks_repository.dart';

class HomeViewmodel extends ChangeNotifier {
  HomeViewmodel(this._tasksRepository);

  final ITasksRepository _tasksRepository;

  int _page = 0;
  bool _isLoadCompleted = false;
  final int _limit = 15;
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> loadMoreTasks() async {
    if (_isLoadCompleted) return;

    final newTasks = await _tasksRepository.fetchTasks(_page, _limit);

    if (newTasks.isLeft) {
      print(newTasks.left.message);
    }

    if (newTasks.right.isEmpty || newTasks.right.length < _limit) {
      _isLoadCompleted = true;
    }

    _tasks.addAll(newTasks.right);
    _page += 1;

    notifyListeners();
  }

  Future<void> toggleTask(int index) async {
    final result = await _tasksRepository.toggleTask(index);

    if (result.isLeft) {
      showError(result.left);
    }

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

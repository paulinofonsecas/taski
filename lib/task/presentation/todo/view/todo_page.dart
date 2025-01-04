import 'package:flutter/material.dart';
import 'package:taski/dependencies.dart';
import 'package:taski/task/presentation/todo/widgets/todo_body.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: TodoView(),
    );
  }
}

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return TodoBody(
      viewModel: getIt(),
    );
  }
}

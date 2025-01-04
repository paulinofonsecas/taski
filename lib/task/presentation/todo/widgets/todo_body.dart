import 'package:flutter/material.dart';
import 'package:taski/dependencies.dart';
import 'package:taski/task/presentation/todo/view_models/todo_viewmodel.dart';
import 'package:taski/task/presentation/todo/widgets/task_widget.dart';
import 'package:taski/task/presentation/widgets/custom_header_widget.dart';
import 'package:taski/task/presentation/widgets/empty_task_list_widget.dart';

class TodoBody extends StatefulWidget {
  const TodoBody({super.key});

  @override
  State<TodoBody> createState() => _TodoBodyState();
}

class _TodoBodyState extends State<TodoBody> {
  late final TodoViewmodel viewModel;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    viewModel = getIt();
    viewModel.loadMoreTasks();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        viewModel.loadMoreTasks();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            if (viewModel.tasks.isEmpty) {
              return const Column(
                children: [
                  CustomHeaderWidget(),
                  Expanded(child: Center(child: EmptyTaskListWidget())),
                ],
              );
            }

            if (viewModel.isLoading) {
              return const Column(
                children: [
                  CustomHeaderWidget(),
                  Expanded(child: Center(child: CircularProgressIndicator())),
                ],
              );
            }

            return CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(
                  child: CustomHeaderWidget(),
                ),
                SliverList.builder(
                  itemCount: viewModel.tasks.length,
                  itemBuilder: (_, index) {
                    final task = viewModel.tasks[index];

                    return TaskWidget(
                      key: ValueKey(task.id),
                      task: task,
                      toggle: () => viewModel.toggleTask(task),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

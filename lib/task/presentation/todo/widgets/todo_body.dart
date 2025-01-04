import 'package:flutter/material.dart';
import 'package:taski/task/presentation/todo/view_models/todo_viewmodel.dart';
import 'package:taski/task/presentation/todo/widgets/task_widget.dart';
import 'package:taski/task/presentation/widgets/custom_header_widget.dart';
import 'package:taski/task/presentation/widgets/empty_task_list_widget.dart';

class TodoBody extends StatefulWidget {
  const TodoBody({required this.viewModel, super.key});

  final TodoViewModel viewModel;

  @override
  State<TodoBody> createState() => _TodoBodyState();
}

class _TodoBodyState extends State<TodoBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    widget.viewModel.loadMoreTasks();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        widget.viewModel.loadMoreTasks();
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
          listenable: widget.viewModel,
          builder: (context, _) {
            if (widget.viewModel.tasks.isEmpty) {
              return Column(
                children: [
                  CustomHeaderWidget(viewModel: widget.viewModel),
                  const Expanded(child: Center(child: EmptyTaskListWidget())),
                ],
              );
            }

            if (widget.viewModel.isLoading) {
              return Column(
                children: [
                  CustomHeaderWidget(viewModel: widget.viewModel),
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ],
              );
            }

            return CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: CustomHeaderWidget(viewModel: widget.viewModel),
                ),
                SliverList.builder(
                  itemCount: widget.viewModel.tasks.length,
                  itemBuilder: (_, index) {
                    final task = widget.viewModel.tasks[index];

                    return TaskWidget(
                      key: ValueKey(task.id),
                      task: task,
                      toggle: () => widget.viewModel.toggleTask(task),
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

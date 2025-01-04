import 'package:flutter/material.dart';
import 'package:taski/task/presentation/home/view_models/home_viewmodel.dart';
import 'package:taski/task/presentation/home/widgets/custom_header_widget.dart';
import 'package:taski/task/presentation/home/widgets/empty_task_list_widget.dart';
import 'package:taski/task/presentation/home/widgets/task_widget.dart';

/// {@template home_body}
/// Body of the HomePage.
///
/// Add what it does
/// {@endtemplate}
class HomeBody extends StatefulWidget {
  /// {@macro home_body}
  const HomeBody({required this.viewModel, super.key});

  final HomeViewmodel viewModel;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
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
              return const Column(
                children: [
                  CustomHeaderWidget(),
                  Expanded(child: Center(child: EmptyTaskListWidget())),
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
                if (widget.viewModel.tasks.isEmpty)
                  const SliverToBoxAdapter(child: EmptyTaskListWidget())
                else
                  SliverList.builder(
                    itemCount: widget.viewModel.tasks.length,
                    itemBuilder: (_, index) {
                      final task = widget.viewModel.tasks[index];

                      return TaskWidget(
                        key: ValueKey(task.id),
                        task: task,
                        toggle: () => widget.viewModel.toggleTask(task.id),
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

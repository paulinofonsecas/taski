import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taski/task/presentation/todo/widgets/task_widget.dart';
import 'package:taski/task/presentation/search/viewmodel/search_viewmodel.dart';
import 'package:taski/task/presentation/search/widgets/empty_task_widget.dart';
import 'package:taski/task/presentation/search/widgets/search_custom_header.dart';

/// {@template search_body}
/// Body of the SearchPage.
///
/// Add what it does
/// {@endtemplate}
class SearchBody extends StatefulWidget {
  /// {@macro search_body}
  const SearchBody({super.key});

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  late final SearchViewmodel viewModel;

  @override
  void initState() {
    viewModel = context.read();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            if (viewModel.isLoading) {
              return const Column(
                children: [
                  SearchCustomHeader(),
                  Expanded(child: Center(child: CircularProgressIndicator())),
                ],
              );
            }

            if (viewModel.tasks.isEmpty && viewModel.searchText.isNotEmpty) {
              return const Column(
                children: [
                  SearchCustomHeader(),
                  Expanded(child: Center(child: EmptyTaskWidget())),
                ],
              );
            }

            if (viewModel.tasks.isEmpty && viewModel.searchText.isEmpty) {
              return const Column(
                children: [
                  SearchCustomHeader(),
                ],
              );
            }

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(
                  child: SearchCustomHeader(),
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

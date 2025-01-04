import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taski/task/presentation/commom/widgets/empty_task_list_widget.dart';
import 'package:taski/task/presentation/done/viewmodel/done_viewmodel.dart';
import 'package:taski/task/presentation/done/widgets/done_custom_header.dart';
import 'package:taski/task/presentation/done/widgets/task_done_widget.dart';

class DoneBody extends StatefulWidget {
  const DoneBody({super.key});

  @override
  State<DoneBody> createState() => _DoneBodyState();
}

class _DoneBodyState extends State<DoneBody> {
  late final DoneViewmodel viewModel;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    viewModel = context.read();

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
            if (viewModel.isLoading) {
              return const Column(
                children: [
                  DoneCustomHeader(),
                  Expanded(child: Center(child: CircularProgressIndicator())),
                ],
              );
            }

            if (viewModel.tasks.isEmpty) {
              return const Column(
                children: [
                  DoneCustomHeader(),
                  Expanded(child: Center(child: EmptyTaskListWidget())),
                ],
              );
            }

            return CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(
                  child: DoneCustomHeader(),
                ),
                SliverList.builder(
                  itemCount: viewModel.tasks.length,
                  itemBuilder: (_, index) {
                    final task = viewModel.tasks[index];

                    return TaskDoneWidget(
                      key: ValueKey(task.id),
                      task: task,
                      toggle: () => viewModel.toggleTask(task),
                      onDeleteTap: () {
                        // ignore: inference_failure_on_function_invocation
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Excluir tarefa'),
                            content:
                                const Text('Tem certeza que deseja excluir?'),
                            actions: [
                              TextButton(
                                child: const Text('Cancelar'),
                                onPressed: () => Navigator.pop(context),
                              ),
                              TextButton(
                                child: Text(
                                  'Excluir',
                                  style: GoogleFonts.urbanist(
                                    color: const Color(0xffFF5E5E),
                                  ),
                                ),
                                onPressed: () {
                                  viewModel.deleteTask(task);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
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

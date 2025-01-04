import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taski/task/presentation/done/viewmodel/done_viewmodel.dart';
import 'package:taski/task/presentation/done/widgets/done_custom_header.dart';
import 'package:taski/task/presentation/done/widgets/task_done_widget.dart';
import 'package:taski/task/presentation/widgets/empty_task_list_widget.dart';

class DoneBody extends StatefulWidget {
  const DoneBody({required this.viewModel, super.key});

  final DoneViewModel viewModel;

  @override
  State<DoneBody> createState() => _DoneBodyState();
}

class _DoneBodyState extends State<DoneBody> {
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
            if (widget.viewModel.isLoading) {
              return const Column(
                children: [
                  DoneCustomHeader(),
                  Expanded(child: Center(child: CircularProgressIndicator())),
                ],
              );
            }

            if (widget.viewModel.tasks.isEmpty) {
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
                  itemCount: widget.viewModel.tasks.length,
                  itemBuilder: (_, index) {
                    final task = widget.viewModel.tasks[index];

                    return TaskDoneWidget(
                      key: ValueKey(task.id),
                      task: task,
                      toggle: () => widget.viewModel.toggleTask(task),
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
                                  widget.viewModel.deleteTask(task);
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

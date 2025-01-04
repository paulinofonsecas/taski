import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taski/task/presentation/commom/widgets/empty_task_list_widget.dart';
import 'package:taski/task/presentation/done/viewmodel/done_viewmodel.dart';
import 'package:taski/task/presentation/done/widgets/task_done_widget.dart';
import 'package:taski/task/presentation/home/widgets/custom_app_bar.dart';

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

class DoneCustomHeader extends StatelessWidget {
  const DoneCustomHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        const CustomAppBar(),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Completed Tasks',
              style: GoogleFonts.urbanist(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Delete All',
                style: GoogleFonts.urbanist(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xffFF5E5E),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

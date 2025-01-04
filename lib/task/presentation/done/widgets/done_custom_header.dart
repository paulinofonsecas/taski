import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taski/task/presentation/widgets/custom_app_bar.dart';
import 'package:taski/task/presentation/done/viewmodel/done_viewmodel.dart';

class DoneCustomHeader extends StatelessWidget {
  const DoneCustomHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<DoneViewmodel>();

    return Column(
      children: [
        const SizedBox(height: 26),
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
            Visibility(
              visible: viewModel.tasks.isNotEmpty,
              child: TextButton(
                onPressed: () {
                  // ignore: inference_failure_on_function_invocation
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete all Tasks'),
                      content: const Text('You want to delete all?'),
                      actions: [
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: Text(
                            'Erase',
                            style: GoogleFonts.urbanist(
                              color: const Color(0xffFF5E5E),
                            ),
                          ),
                          onPressed: () {
                            viewModel.deleteAllTasks();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
                child: Text(
                  'Delete All',
                  style: GoogleFonts.urbanist(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xffFF5E5E),
                  ),
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

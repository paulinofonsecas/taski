import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taski/core/theme/colors.dart';
import 'package:taski/task/presentation/todo/view_models/todo_viewmodel.dart';
import 'package:taski/task/presentation/widgets/custom_app_bar.dart';

class CustomHeaderWidget extends StatelessWidget {
  const CustomHeaderWidget({
    required this.viewModel,
    super.key,
  });

  final TodoViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 26),
        const CustomAppBar(),
        const SizedBox(height: 32),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Welcome, ',
                    style: GoogleFonts.urbanist(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: 'John',
                    style: GoogleFonts.urbanist(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: kBlue,
                    ),
                  ),
                  const TextSpan(
                    text: '.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ListenableBuilder(
              listenable: viewModel,
              builder: (context, _) {
                return Text(
                  'You’ve got '
                  '${viewModel.tasks.length} tasks to do.',
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: kSlateBlue,
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

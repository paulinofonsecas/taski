import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taski/dependencies.dart';
import 'package:taski/task/presentation/commom/widgets/custom_app_bar.dart';
import 'package:taski/task/presentation/home/view_models/home_viewmodel.dart';

class CustomHeaderWidget extends StatelessWidget {
  const CustomHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<HomeViewmodel>();

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
                      color: const Color(0xff007FFF),
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
                    color: const Color(0xff8D9CB8),
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

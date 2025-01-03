import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taski/task/presentation/home/widgets/custom_app_bar.dart';

import 'package:taski/task/presentation/home/widgets/task_widget.dart';

/// {@template home_body}
/// Body of the HomePage.
///
/// Add what it does
/// {@endtemplate}
class HomeBody extends StatelessWidget {
  /// {@macro home_body}
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(),
              const SizedBox(height: 32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildRichText(),
                  const SizedBox(height: 10),
                  Text(
                    'You’ve got 7 tasks to do.',
                    style: GoogleFonts.urbanist(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff8D9CB8),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ...List.generate(
                30,
                (index) => const TaskWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text buildRichText() {
    return Text.rich(
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
    );
  }
}

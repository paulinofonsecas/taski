import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taski/task/presentation/create/view/create_page.dart';

import 'package:taski/task/presentation/widgets/create_new_task_widget.dart';

class EmptyTaskListWidget extends StatelessWidget {
  const EmptyTaskListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/svgs/empty.svg'),
        const SizedBox(height: 24),
        Text(
          'You have no task listed.',
          style: GoogleFonts.urbanist(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xff8D9CB8),
          ),
        ),
        const SizedBox(height: 28),
        CreateNewTaskWidget(
          onTap: () {
            CreatePage.customShowBottomSheet(context);
          },
        ),
      ],
    );
  }
}

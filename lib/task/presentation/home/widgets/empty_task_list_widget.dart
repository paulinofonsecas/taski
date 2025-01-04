import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taski/task/presentation/create/view/create_page.dart';

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

class CreateNewTaskWidget extends StatelessWidget {
  const CreateNewTaskWidget({
    super.key,
    this.onTap,
  });

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xff007FFF).withValues(alpha: .10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/svgs/plus.svg'),
            const SizedBox(width: 12),
            Text(
              'Create task',
              style: GoogleFonts.urbanist(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

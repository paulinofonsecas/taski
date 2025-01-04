import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taski/task/presentation/todo/widgets/custom_image_widget.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            SvgPicture.asset('assets/svgs/taski_logo.svg'),
            const SizedBox(width: 8),
            SvgPicture.asset('assets/svgs/taski.svg'),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            Text(
              'John',
              style: GoogleFonts.urbanist(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 14),
            const CustomImageWidget(),
          ],
        ),
      ],
    );
  }
}

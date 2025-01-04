import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taski/core/theme/colors.dart';

class EmptyTaskWidget extends StatelessWidget {
  const EmptyTaskWidget({
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
          'No result found.',
          style: GoogleFonts.urbanist(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: kSlateBlue,
          ),
        ),
      ],
    );
  }
}

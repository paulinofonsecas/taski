import 'package:flutter/material.dart';

class TreeDots extends StatelessWidget {
  const TreeDots({
    required this.onTap,
    super.key,
  });

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 24,
        height: 24,
        child: Row(
          children: [
            Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xffC6CFDC),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 3),
            Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xffC6CFDC),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 3),
            Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xffC6CFDC),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
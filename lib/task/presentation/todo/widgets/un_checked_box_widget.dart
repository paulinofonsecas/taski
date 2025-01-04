import 'package:flutter/material.dart';

class UnCheckedBoxWidget extends StatelessWidget {
  const UnCheckedBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: const Color(0xffC6CFDC),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
    );
  }
}

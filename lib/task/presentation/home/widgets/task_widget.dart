// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taski/task/presentation/home/widgets/task_status_widget.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({
    super.key,
  });

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isSelected = false;
  bool isExpanded = false;

  void toggle() => setState(() => isSelected = !isSelected);
  void toggleExpand() => setState(() => isExpanded = !isExpanded);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleExpand,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xffF5F7F9),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    TaskStatusWidget(
                      isSelected: isSelected,
                      toggle: toggle,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Design usecase page',
                      style: GoogleFonts.urbanist(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff3F3D56),
                      ),
                    ),
                  ],
                ),
                if (!isExpanded)
                  TreeDots(
                    onTap: toggleExpand,
                  ),
              ],
            ),
            if (isExpanded) ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(
                  left: 42,
                  right: 8,
                ),
                child: Text(
                  "By the time a prospect arrives at your signup page, in most cases, they've already By the time a prospect arrives at your signup page, in most cases.",
                  style: GoogleFonts.urbanist(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff8D9CB8),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

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

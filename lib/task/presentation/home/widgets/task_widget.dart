// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taski/task/domain/entities/task.dart';
import 'package:taski/task/presentation/home/widgets/task_status_widget.dart';
import 'package:taski/task/presentation/home/widgets/tree_dots.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({
    required this.task,
    required this.toggle,
    super.key,
  });

  final Task task;
  final void Function() toggle;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isExpanded = false;

  void toggleExpand() => setState(() => isExpanded = !isExpanded);

  String getSuficientTodo(String todo) {
    if (todo.length > 32) {
      return '${todo.substring(0, 32)}...';
    } else {
      return todo;
    }
  }

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
                      isSelected: widget.task.isCompleted,
                      toggle: widget.toggle,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      getSuficientTodo(widget.task.title),
                      maxLines: isExpanded ? null : 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.urbanist(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff3F3D56),
                      ),
                    ),
                  ],
                ),
                if (!isExpanded && widget.task.description.isNotEmpty)
                  TreeDots(
                    onTap: toggleExpand,
                  ),
              ],
            ),
            if (isExpanded && widget.task.description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(
                  left: 42,
                  right: 8,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.task.description,
                    style: GoogleFonts.urbanist(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff8D9CB8),
                    ),
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

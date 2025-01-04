import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taski/task/domain/entities/task.dart';
import 'package:taski/task/presentation/home/widgets/task_status_widget.dart';

class TaskDoneWidget extends StatefulWidget {
  const TaskDoneWidget({
    required this.task,
    required this.toggle,
    super.key,
  });

  final Task task;
  final void Function() toggle;

  @override
  State<TaskDoneWidget> createState() => _TaskDoneWidgetState();
}

class _TaskDoneWidgetState extends State<TaskDoneWidget> {
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
    return Container(
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
              const SvgButton(
                iconPath: 'assets/svgs/trash.svg',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SvgButton extends StatelessWidget {
  const SvgButton({
    required this.iconPath,
    super.key,
  });

  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 4,
      ),
      child: SvgPicture.asset(
        iconPath,
        width: 12,
        height: 16,
      ),
    );
  }
}

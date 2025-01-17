import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taski/core/theme/colors.dart';
import 'package:taski/task/domain/entities/task.dart';
import 'package:taski/task/presentation/todo/widgets/task_status_widget.dart';

class TaskDoneWidget extends StatefulWidget {
  const TaskDoneWidget({
    required this.task,
    required this.toggle,
    required this.onDeleteTap,
    super.key,
  });

  final Task task;
  final void Function() toggle;
  final GestureTapCallback onDeleteTap;

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
        color: kPaleWhite,
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
                      color: kSlatePurple,
                    ),
                  ),
                ],
              ),
              SvgButton(
                iconPath: 'assets/svgs/trash.svg',
                onTap: widget.onDeleteTap,
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
    required this.onTap,
    super.key,
  });

  final GestureTapCallback onTap;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 4,
        ),
        child: SvgPicture.asset(
          iconPath,
          width: 12,
          height: 16,
        ),
      ),
    );
  }
}

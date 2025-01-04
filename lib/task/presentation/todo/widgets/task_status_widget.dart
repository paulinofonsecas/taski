import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taski/core/theme/colors.dart';

class TaskStatusWidget extends StatefulWidget {
  const TaskStatusWidget({
    required this.isSelected,
    required this.toggle,
    super.key,
  });

  final bool isSelected;
  final void Function() toggle;

  @override
  State<TaskStatusWidget> createState() => _TaskStatusWidgetState();
}

class _TaskStatusWidgetState extends State<TaskStatusWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.toggle,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: widget.isSelected ? kMutedAzure : Colors.transparent,
          border: Border.all(
            color: kMutedAzure,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(7),
        ),
        child: widget.isSelected
            ? Center(
                child: SvgPicture.asset('assets/svgs/check.svg'),
              )
            : null,
      ),
    );
  }
}

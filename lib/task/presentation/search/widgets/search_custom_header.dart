import 'package:flutter/material.dart';
import 'package:taski/task/presentation/commom/widgets/custom_app_bar.dart';
import 'package:taski/task/presentation/search/widgets/custom_text_field_widget.dart';

class SearchCustomHeader extends StatelessWidget {
  const SearchCustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 26),
        CustomAppBar(),
        SizedBox(height: 32),
        CustomTextFieldWidget(),
        SizedBox(height: 32),
      ],
    );
  }
}

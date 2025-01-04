import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taski/core/theme/colors.dart';
import 'package:taski/task/presentation/search/viewmodel/search_viewmodel.dart';

class CustomTextFieldWidget extends StatefulWidget {
  const CustomTextFieldWidget({
    super.key,
  });

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  late final SearchViewmodel viewmodel;
  late final TextEditingController _searchTextController;

  @override
  void initState() {
    viewmodel = context.read();
    _searchTextController = TextEditingController();

    _searchTextController.addListener(() {
      if (_searchTextController.text.isEmpty) {
        return;
      }

      viewmodel.searchTasks(_searchTextController.text);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: kBlue.withValues(
              alpha: .5,
            ),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: Center(
              child: SvgPicture.asset(
                'assets/svgs/mini_search.svg',
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchTextController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search for tasks',
                hintStyle: GoogleFonts.urbanist(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: kSlatePurple,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: () {
              _searchTextController.clear();
            },
            child: SizedBox(
              width: 16,
              height: 16,
              child: Center(
                child: SvgPicture.asset(
                  'assets/svgs/close.svg',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

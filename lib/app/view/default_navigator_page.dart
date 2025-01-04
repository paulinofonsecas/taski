import 'package:flutter/material.dart';
import 'package:taski/app/view/custom_bottom_bar_item.dart';
import 'package:taski/core/theme/colors.dart';
import 'package:taski/task/presentation/create/view/create_page.dart';
import 'package:taski/task/presentation/done/view/done_page.dart';
import 'package:taski/task/presentation/search/view/search_page.dart';
import 'package:taski/task/presentation/todo/view/todo_page.dart';

class DefaultNavigatorPage extends StatefulWidget {
  const DefaultNavigatorPage({super.key});

  @override
  State<DefaultNavigatorPage> createState() => _DefaultNavigatorPageState();
}

class _DefaultNavigatorPageState extends State<DefaultNavigatorPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    TodoPage(),
    SizedBox(),
    SearchPage(),
    DonePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      switch (index) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
        case 3:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: kPaleWhite,
              width: 2,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomBottomBarItem(
              onTap: () {
                _onItemTapped(0);
              },
              label: 'Todo',
              iconPath: 'assets/svgs/todo.svg',
              color: _selectedIndex == 0 ? kBlue : kMutedAzure,
            ),
            CustomBottomBarItem(
              onTap: () {
                CreatePage.customShowBottomSheet(context);
              },
              label: 'Create',
              iconPath: 'assets/svgs/create.svg',
              color: _selectedIndex == 1 ? kBlue : kMutedAzure,
            ),
            CustomBottomBarItem(
              onTap: () {
                _onItemTapped(2);
              },
              label: 'Search',
              iconPath: 'assets/svgs/search.svg',
              color: _selectedIndex == 2 ? kBlue : kMutedAzure,
            ),
            CustomBottomBarItem(
              onTap: () {
                _onItemTapped(3);
              },
              label: 'Done',
              iconPath: 'assets/svgs/done.svg',
              color: _selectedIndex == 3 ? kBlue : kMutedAzure,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:taski/dependencies.dart';
import 'package:taski/task/presentation/home/view_models/home_viewmodel.dart';
import 'package:taski/task/presentation/home/widgets/home_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: HomeView(
        viewModel: getIt(),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({required this.viewModel, super.key});

  final HomeViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    return HomeBody(
      viewModel: viewModel,
    );
  }
}

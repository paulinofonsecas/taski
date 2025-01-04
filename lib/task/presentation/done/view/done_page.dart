import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taski/dependencies.dart';
import 'package:taski/task/presentation/done/viewmodel/done_viewmodel.dart';
import 'package:taski/task/presentation/done/widgets/done_body.dart';

/// {@template done_page}
/// A description for DonePage
/// {@endtemplate}
class DonePage extends StatelessWidget {
  /// {@macro done_page}
  const DonePage({super.key});

  /// The static route for DonePage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const DonePage());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DoneViewModel(
        tasksRepository: getIt(),
        todoViewmodel: getIt(),
      ),
      child: const Scaffold(
        body: DoneView(),
      ),
    );
  }
}

/// {@template done_view}
/// Displays the Body of DoneView
/// {@endtemplate}
class DoneView extends StatelessWidget {
  /// {@macro done_view}
  const DoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return DoneBody(
      viewModel: context.read<DoneViewModel>(),
    );
  }
}

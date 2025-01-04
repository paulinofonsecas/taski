import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taski/core/config/dependencies.dart';
import 'package:taski/task/presentation/create/viewmodel/create_viewmodel.dart';
import 'package:taski/task/presentation/create/widgets/create_body.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  static Future<void> customShowBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      barrierColor: Colors.transparent,
      elevation: 0,
      builder: (BuildContext context) {
        return const CreatePage();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateViewmodel(
        tasksRepository: getIt(),
        todoViewmodel: getIt(),
      ),
      child: const CreateView(),
    );
  }
}

class CreateView extends StatelessWidget {
  const CreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return CreateBody(
      viewModel: context.watch<CreateViewmodel>(),
    );
  }
}

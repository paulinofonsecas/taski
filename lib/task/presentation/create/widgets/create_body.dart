// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taski/task/presentation/create/viewmodel/create_viewmodel.dart';
import 'package:taski/task/presentation/todo/widgets/un_checked_box_widget.dart';

/// {@template create_body}
/// Body of the CreatePage.
///
/// Add what it does
/// {@endtemplate}
class CreateBody extends StatefulWidget {
  /// {@macro create_body}
  const CreateBody({
    required this.viewModel,
    super.key,
  });

  final CreateViewmodel viewModel;

  @override
  State<CreateBody> createState() => _CreateBodyState();
}

class _CreateBodyState extends State<CreateBody> {
  final _formKey = GlobalKey<FormState>();
  final _todoController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void initState() {
    widget.viewModel.addListener(() {
      if (widget.viewModel.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ocorreu um erro ao criar a tarefa'),
          ),
        );
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _todoController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(42),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xffc6cfdc).withValues(alpha: .50),
              blurRadius: 24,
              offset: const Offset(0, -6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TodoTextInput(
              controller: _todoController,
            ),
            const SizedBox(height: 28),
            NoteTextInput(
              controller: _noteController,
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  await widget.viewModel.createTask(
                    _todoController.text,
                    _noteController.text,
                  );

                  if (!widget.viewModel.hasError) {
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Create',
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff007FFF),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TodoTextInput extends StatelessWidget {
  const TodoTextInput({
    required this.controller,
    super.key,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const UnCheckedBoxWidget(),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            controller: controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }

              return null;
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              hintText: 'What needs to be done?',
              hintStyle: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xffC6CFDC),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NoteTextInput extends StatelessWidget {
  const NoteTextInput({
    required this.controller,
    super.key,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset('assets/svgs/edit.svg'),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            controller: controller,
            maxLines: 3,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              hintText: 'Add a note...',
              hintStyle: GoogleFonts.urbanist(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xffC6CFDC),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

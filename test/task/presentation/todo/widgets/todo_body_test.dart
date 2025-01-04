import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski/task/data/models/task_model.dart';
import 'package:taski/task/domain/repositories/i_tasks_repository.dart';
import 'package:taski/task/presentation/todo/view_models/todo_viewmodel.dart';
import 'package:taski/task/presentation/todo/widgets/task_widget.dart';
import 'package:taski/task/presentation/todo/widgets/todo_body.dart';
import 'package:taski/task/presentation/widgets/custom_header_widget.dart';
import 'package:taski/task/presentation/widgets/empty_task_list_widget.dart';

class MockTasksRepository extends Mock implements ITasksRepository {}

void main() {
  group('Todo page', () {
    testWidgets('should display CustomHeaderWidget', (tester) async {
      final tasksRepository = MockTasksRepository();
      final viewModel = TodoViewModel(tasksRepository);

      when(() => tasksRepository.fetchTasks(any(), any()))
          .thenAnswer((_) async => const Right([]));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TodoBody(
              viewModel: viewModel,
            ),
          ),
        ),
      );

      expect(find.byType(CustomHeaderWidget), findsOneWidget);
    });

    testWidgets('should display EmptyTaskListWidget when tasks are empty',
        (tester) async {
      final tasksRepository = MockTasksRepository();
      final viewModel = TodoViewModel(tasksRepository);

      when(() => tasksRepository.fetchTasks(any(), any()))
          .thenAnswer((_) async => const Right([]));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TodoBody(
              viewModel: viewModel,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(EmptyTaskListWidget), findsOneWidget);
      expect(find.text('You have no task listed.'), findsOneWidget);
    });

    testWidgets('should display tasks when tasks are not empty',
        (tester) async {
      final tasksRepository = MockTasksRepository();
      final viewModel = TodoViewModel(tasksRepository);

      when(() => tasksRepository.fetchTasks(any(), any())).thenAnswer(
        (_) async => Right([
          TaskModel.create(title: 'title1', description: 'description'),
          TaskModel.create(title: 'title2', description: 'description'),
          TaskModel.create(title: 'title3', description: 'description'),
        ]),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TodoBody(
              viewModel: viewModel,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(TaskWidget), findsWidgets);
    });

    testWidgets('should expand task when task is tapped', (tester) async {
      final tasksRepository = MockTasksRepository();
      final viewModel = TodoViewModel(tasksRepository);

      when(() => tasksRepository.fetchTasks(any(), any())).thenAnswer(
        (_) async => Right([
          TaskModel.create(title: 'title1', description: 'description'),
        ]),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TodoBody(
              viewModel: viewModel,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('title1'), findsOneWidget);
      expect(find.text('description'), findsNothing);

      await tester.tap(find.text('title1'));

      await tester.pumpAndSettle();

      expect(find.text('description'), findsOneWidget);
    });
  });
}

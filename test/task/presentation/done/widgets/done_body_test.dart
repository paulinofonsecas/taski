import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:taski/task/data/models/task_model.dart';
import 'package:taski/task/domain/repositories/i_tasks_repository.dart';
import 'package:taski/task/presentation/done/viewmodel/done_viewmodel.dart';
import 'package:taski/task/presentation/done/widgets/done_body.dart';
import 'package:taski/task/presentation/done/widgets/done_custom_header.dart';
import 'package:taski/task/presentation/done/widgets/task_done_widget.dart';
import 'package:taski/task/presentation/todo/view_models/todo_viewmodel.dart';
import 'package:taski/task/presentation/todo/widgets/task_status_widget.dart';
import 'package:taski/task/presentation/widgets/empty_task_list_widget.dart';

class MockTasksRepository extends Mock implements ITasksRepository {}

void main() {
  group('Done page', () {
    testWidgets('should display DoneCustomHeader', (tester) async {
      final tasksRepository = MockTasksRepository();
      final viewModel = DoneViewModel(
        tasksRepository: tasksRepository,
        todoViewmodel: TodoViewModel(tasksRepository),
      );

      when(() => tasksRepository.fetchCompletedTasks(any(), any()))
          .thenAnswer((_) async => const Right([]));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (context) => viewModel,
              child: DoneBody(
                viewModel: viewModel,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(DoneCustomHeader), findsOneWidget);
    });

    testWidgets('should display EmptyTaskListWidget when tasks are empty',
        (tester) async {
      final tasksRepository = MockTasksRepository();
      final viewModel = DoneViewModel(
        tasksRepository: tasksRepository,
        todoViewmodel: TodoViewModel(tasksRepository),
      );

      when(() => tasksRepository.fetchCompletedTasks(any(), any()))
          .thenAnswer((_) async => const Right([]));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (context) => viewModel,
              child: DoneBody(
                viewModel: viewModel,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(EmptyTaskListWidget), findsOneWidget);
      expect(find.text('You have no task listed.'), findsOneWidget);
    });

    testWidgets('should display a completed list tasks', (tester) async {
      final tasksRepository = MockTasksRepository();
      final viewModel = DoneViewModel(
        tasksRepository: tasksRepository,
        todoViewmodel: TodoViewModel(tasksRepository),
      );

      when(() => tasksRepository.fetchTasks(any(), any())).thenAnswer(
        (_) async => const Right([]),
      );
      when(() => tasksRepository.fetchCompletedTasks(any(), any())).thenAnswer(
        (_) async => Right([
          TaskModel.create(
            title: 'Task 1',
            description: 'Description 1',
            isCompleted: true,
          ),
          TaskModel.create(
            title: 'Task 2',
            description: 'Description 2',
            isCompleted: true,
          ),
        ]),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (context) => viewModel,
              child: DoneBody(
                viewModel: viewModel,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Task 1'), findsOneWidget);
      expect(find.text('Task 2'), findsOneWidget);
    });

    testWidgets('should toggle task', (tester) async {
      final tasksRepository = MockTasksRepository();
      final viewModel = DoneViewModel(
        tasksRepository: tasksRepository,
        todoViewmodel: TodoViewModel(tasksRepository),
      );
      final task = TaskModel.create(
        title: 'Task 1',
        description: 'Description 1',
        isCompleted: true,
      );

      when(() => tasksRepository.toggleTask(task)).thenAnswer(
        (_) async => const Right(null),
      );
      when(() => tasksRepository.fetchCompletedTasks(any(), any())).thenAnswer(
        (_) async => Right([
          task,
          TaskModel.create(
            title: 'Task 2',
            isCompleted: true,
            description: 'Description 2',
          ),
        ]),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (context) => viewModel,
              child: DoneBody(
                viewModel: viewModel,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Task 1'), findsOneWidget);
      expect(find.text('Task 2'), findsOneWidget);

      when(() => tasksRepository.fetchCompletedTasks(any(), any())).thenAnswer(
        (_) async => Right([
          TaskModel.create(
            title: 'Task 2',
            isCompleted: true,
            description: 'Description 2',
          ),
        ]),
      );

      when(() => tasksRepository.fetchTasks(any(), any())).thenAnswer(
        (_) async => Right([
          TaskModel.create(
            title: 'Task 2',
            isCompleted: true,
            description: 'Description 2',
          ),
        ]),
      );

      await tester.tap(find.byType(TaskStatusWidget).first);

      await tester.pumpAndSettle();

      expect(find.text('Task 1'), findsNothing);
      expect(find.text('Task 2'), findsOneWidget);
    });

    testWidgets('should delete task', (tester) async {
      final tasksRepository = MockTasksRepository();
      final viewModel = DoneViewModel(
        tasksRepository: tasksRepository,
        todoViewmodel: TodoViewModel(tasksRepository),
      );
      final task = TaskModel.create(
        title: 'Task 1',
        description: 'Description 1',
        isCompleted: true,
      );

      when(() => tasksRepository.deleteTask(any())).thenAnswer(
        (_) async => const Right(null),
      );
      when(() => tasksRepository.fetchCompletedTasks(any(), any())).thenAnswer(
        (_) async => Right([
          task,
          TaskModel.create(
            title: 'Task 2',
            isCompleted: true,
            description: 'Description 2',
          ),
        ]),
      );
      when(() => tasksRepository.fetchTasks(any(), any())).thenAnswer(
        (_) async => Right([
          TaskModel.create(
            title: 'Task 2',
            isCompleted: true,
            description: 'Description 2',
          ),
        ]),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (context) => viewModel,
              child: DoneBody(
                viewModel: viewModel,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.byType(SvgButton).first);

      await tester.pumpAndSettle();

      expect(find.text('Excluir'), findsOneWidget);

      when(() => tasksRepository.fetchCompletedTasks(any(), any())).thenAnswer(
        (_) async => Right([
          TaskModel.create(
            title: 'Task 2',
            isCompleted: true,
            description: 'Description 2',
          ),
        ]),
      );

      when(() => tasksRepository.fetchTasks(any(), any())).thenAnswer(
        (_) async => Right([
          TaskModel.create(
            title: 'Task 2',
            isCompleted: true,
            description: 'Description 2',
          ),
        ]),
      );

      await tester.tap(find.text('Excluir'));

      await tester.pumpAndSettle();

      expect(find.text('Task 1'), findsNothing);
      expect(find.text('Task 2'), findsOneWidget);
    });
  });
}

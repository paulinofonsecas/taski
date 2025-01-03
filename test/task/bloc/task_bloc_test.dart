// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taski/task/bloc/bloc.dart';

void main() {
  group('TaskBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          TaskBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final taskBloc = TaskBloc();
      expect(taskBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<TaskBloc, TaskState>(
      'CustomTaskEvent emits nothing',
      build: TaskBloc.new,
      act: (bloc) => bloc.add(const CustomTaskEvent()),
      expect: () => <TaskState>[],
    );
  });
}

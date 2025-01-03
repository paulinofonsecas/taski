// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:taski/task/bloc/bloc.dart';

void main() {
  group('TaskState', () {
    test('supports value equality', () {
      expect(
        TaskState(),
        equals(
          const TaskState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const TaskState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const taskState = TaskState(
            customProperty: 'My property',
          );
          expect(
            taskState.copyWith(),
            equals(taskState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const taskState = TaskState(
            customProperty: 'My property',
          );
          final otherTaskState = TaskState(
            customProperty: 'My property 2',
          );
          expect(taskState, isNot(equals(otherTaskState)));

          expect(
            taskState.copyWith(
              customProperty: otherTaskState.customProperty,
            ),
            equals(otherTaskState),
          );
        },
      );
    });
  });
}

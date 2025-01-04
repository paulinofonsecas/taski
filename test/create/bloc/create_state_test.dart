// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:taski/task/presentation/create/bloc/bloc.dart';

void main() {
  group('CreateState', () {
    test('supports value equality', () {
      expect(
        CreateState(),
        equals(
          const CreateState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const CreateState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const createState = CreateState(
            customProperty: 'My property',
          );
          expect(
            createState.copyWith(),
            equals(createState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const createState = CreateState(
            customProperty: 'My property',
          );
          final otherCreateState = CreateState(
            customProperty: 'My property 2',
          );
          expect(createState, isNot(equals(otherCreateState)));

          expect(
            createState.copyWith(
              customProperty: otherCreateState.customProperty,
            ),
            equals(otherCreateState),
          );
        },
      );
    });
  });
}

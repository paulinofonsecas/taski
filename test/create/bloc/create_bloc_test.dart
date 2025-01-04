// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taski/task/presentation/create/bloc/bloc.dart';

void main() {
  group('CreateBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          CreateBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final createBloc = CreateBloc();
      expect(createBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<CreateBloc, CreateState>(
      'CustomCreateEvent emits nothing',
      build: CreateBloc.new,
      act: (bloc) => bloc.add(const CustomCreateEvent()),
      expect: () => <CreateState>[],
    );
  });
}

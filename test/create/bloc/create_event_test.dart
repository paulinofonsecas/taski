// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:taski/task/presentation/create/bloc/bloc.dart';

void main() {
  group('CreateEvent', () {  
    group('CustomCreateEvent', () {
      test('supports value equality', () {
        expect(
          CustomCreateEvent(),
          equals(const CustomCreateEvent()),
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const CustomCreateEvent(),
          isNotNull
        );
      });
    });
  });
}

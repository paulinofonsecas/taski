// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:taski/task/bloc/bloc.dart';

void main() {
  group('TaskEvent', () {  
    group('CustomTaskEvent', () {
      test('supports value equality', () {
        expect(
          CustomTaskEvent(),
          equals(const CustomTaskEvent()),
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const CustomTaskEvent(),
          isNotNull
        );
      });
    });
  });
}

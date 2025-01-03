// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:taski/task/task.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TaskPage', () {
    group('route', () {
      test('is routable', () {
        expect(TaskPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders TaskView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: TaskPage()));
      expect(find.byType(TaskView), findsOneWidget);
    });
  });
}

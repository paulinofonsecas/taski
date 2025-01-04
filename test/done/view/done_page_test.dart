// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:taski/task/presentation/done/done.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DonePage', () {
    group('route', () {
      test('is routable', () {
        expect(DonePage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders DoneView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: DonePage()));
      expect(find.byType(DoneView), findsOneWidget);
    });
  });
}

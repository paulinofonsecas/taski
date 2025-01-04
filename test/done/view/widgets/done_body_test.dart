// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:taski/task/presentation/done/done.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DoneBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        MaterialApp(home: DoneBody()),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}

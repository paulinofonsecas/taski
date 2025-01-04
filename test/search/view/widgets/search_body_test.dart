// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:taski/task/presentation/search/search.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SearchBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        MaterialApp(home: SearchBody()),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}

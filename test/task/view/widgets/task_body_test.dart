// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:taski/task/task.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TaskBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => TaskBloc(),
          child: MaterialApp(home: TaskBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}

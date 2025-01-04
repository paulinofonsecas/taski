// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:taski/task/presentation/create/create.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CreateBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => CreateBloc(),
          child: MaterialApp(home: CreateBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}

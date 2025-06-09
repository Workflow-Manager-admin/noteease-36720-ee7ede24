import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noteease_frontend/main.dart';

void main() {
  testWidgets('App generation message displayed', (WidgetTester tester) async {
    await tester.pumpWidget(NoteEaseApp());

    expect(find.text('noteease_frontend App is being generated...'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('App bar has correct title', (WidgetTester tester) async {
    await tester.pumpWidget(NoteEaseApp());

    expect(find.text('noteease_frontend'), findsOneWidget);
  });
}

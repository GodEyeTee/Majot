import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:majot/main.dart';

void main() {
  testWidgets('Home page has login and register buttons',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our app has the Register and Login buttons
    expect(find.text('Register'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);

    // Verify that we have the expected icons
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byIcon(Icons.login), findsOneWidget);
  });
}

// Integration test: app launches and shows main UI.
// Run with: flutter test integration_test/app_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:voice_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App launches and shows Voice App screen', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    expect(find.text('Voice App'), findsOneWidget);
    expect(find.text('Generate'), findsOneWidget);
    expect(find.text('Play'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
  });
}

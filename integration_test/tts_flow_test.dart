// Integration test: full TTS flow (enter text → Generate → wait for audio).
// Requires network on first run (model download). May take 2–3+ minutes.
// Run with: flutter test integration_test/tts_flow_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:voice_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Generate TTS and show result (requires network, long timeout)', (WidgetTester tester) async {
    await tester.pumpWidget(const VoiceApp());
    await tester.pumpAndSettle();

    // Short input to keep generation time reasonable
    await tester.enterText(find.byType(TextField), 'Hi');
    await tester.tap(find.text('Generate'));
    await tester.pump();

    // Wait until we see "Generated X samples" or timeout (e.g. 180s for first run with download)
    const timeout = Duration(seconds: 180);
    const step = Duration(milliseconds: 500);
    Duration elapsed = Duration.zero;
    while (elapsed < timeout) {
      await tester.pump(step);
      elapsed += step;
      if (find.textContaining('samples').evaluate().isNotEmpty) {
        break;
      }
      if (find.textContaining('Generated').evaluate().isNotEmpty) {
        break;
      }
    }

    expect(
      find.textContaining('samples'),
      findsWidgets,
      reason: 'Expected "Generated X samples" to appear within $timeout',
    );
  });
}

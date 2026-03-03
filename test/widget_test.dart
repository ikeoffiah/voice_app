// Widget tests for Voice App (Kokoro TTS demo).
// Tests avoid triggering real TTS (no network/native) by only exercising UI and validation.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:voice_app/main.dart';

void main() {
  testWidgets('Voice app shows required UI elements', (WidgetTester tester) async {
    await tester.pumpWidget(const VoiceApp());

    expect(find.text('Voice App'), findsOneWidget);
    expect(find.text('Text to speak'), findsOneWidget);
    expect(find.text('Voice'), findsOneWidget);
    expect(find.text('Generate'), findsOneWidget);
    expect(find.text('Play'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
  });

  testWidgets('Text field has default placeholder content', (WidgetTester tester) async {
    await tester.pumpWidget(const VoiceApp());

    expect(find.textContaining('Kokoro'), findsOneWidget);
  });

  testWidgets('Shows error when Generate is tapped with empty text', (WidgetTester tester) async {
    await tester.pumpWidget(const VoiceApp());

    await tester.enterText(find.byType(TextField), '');
    await tester.tap(find.text('Generate'));
    await tester.pumpAndSettle();

    expect(find.text('Enter some text'), findsOneWidget);
  });

  testWidgets('Play button is disabled when no audio has been generated', (WidgetTester tester) async {
    await tester.pumpWidget(const VoiceApp());

    final playButton = find.byWidgetPredicate(
      (Widget w) =>
          w is FilledButton &&
          (w as FilledButton).onPressed == null &&
          (w as FilledButton).child is Text &&
          ((w as FilledButton).child as Text).data == 'Play',
    );
    expect(playButton, findsOneWidget);
  });

  testWidgets('Voice dropdown shows all available voices', (WidgetTester tester) async {
    await tester.pumpWidget(const VoiceApp());

    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();

    const voices = ['Default', 'Bella', 'Nicole', 'Sarah', 'Adam', 'Michael'];
    for (final voice in voices) {
      expect(find.text(voice), findsWidgets); // Default appears twice (button + menu)
    }
  });

  testWidgets('Selecting a different voice from dropdown updates selection', (WidgetTester tester) async {
    await tester.pumpWidget(const VoiceApp());

    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Bella').last);
    await tester.pumpAndSettle();

    expect(find.text('Bella'), findsWidgets);
  });

  testWidgets('Generate button shows loading state when tapped with text', (WidgetTester tester) async {
    await tester.pumpWidget(const VoiceApp());

    await tester.tap(find.text('Generate'));
    await tester.pump(); // One frame only; do not pumpAndSettle (would wait for TTS)

    expect(find.text('Generating…'), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });
}

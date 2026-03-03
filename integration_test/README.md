# Integration tests

Run on a **device or simulator** (iOS, Android, or macOS with deployment target ≥14.0):

```bash
# List devices
flutter devices

# Run all integration tests on a specific device
flutter test integration_test -d <device_id>

# Examples
flutter test integration_test -d macos      # macOS (requires 14.0+ for plugin)
flutter test integration_test -d chrome      # Chrome
flutter test integration_test -d <ios-simulator-id>
```

## Tests

| File | Description |
|------|-------------|
| `app_test.dart` | App launches and shows main UI (Voice App, Generate, Play, text field, voice dropdown). Fast. |
| `tts_flow_test.dart` | Full flow: enter "Hi" → tap Generate → wait for "Generated X samples". **Requires network** (model download on first run). Timeout 180s; may take 2–3+ minutes on first run. |

Run only the quick launch test:

```bash
flutter test integration_test/app_test.dart -d <device_id>
```

Run the full TTS flow (network + long timeout):

```bash
flutter test integration_test/tts_flow_test.dart -d <device_id>
```

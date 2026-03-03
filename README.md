# Voice App

A Flutter app that uses **flutter_kokoro_tts** from GitHub for on-device text-to-speech.

## Dependency

The app depends on the package via Git:

```yaml
flutter_kokoro_tts:
  git:
    url: https://github.com/ikeoffiah/kokoro_tts.git
```

## Run

```bash
cd voice_app
flutter run
```

Enter text, choose a voice, tap **Generate** (model downloads on first run), then **Play** to hear the speech.

---

## Known issues / Troubleshooting

### Android: CMake not found (`[CXX1300] CMake was not found`)

The **flutter_kokoro_tts** plugin uses native C/C++ on Android and needs CMake for the NDK build. The plugin uses whatever CMake is provided by the Android SDK (no fixed version).

If you see a CMake-not-found error:

1. **Install CMake via Android Studio**  
   **Settings** (or **Preferences** on macOS) → **Languages & Frameworks** → **Android SDK** → **SDK Tools** tab → check **CMake** and **NDK** → Apply. Ensure `ANDROID_HOME` points to this SDK.

2. Run `flutter clean` and then `flutter run` again.

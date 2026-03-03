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

### Android: CMake not found (`[CXX1300] CMake '3.18.1' was not found`)

When building for Android, you may see:

```text
Execution failed for task ':flutter_kokoro_tts:configureCMakeDebug[arm64-v8a]'.
> [CXX1300] CMake '3.18.1' was not found in SDK, PATH, or by cmake.dir property.
```

**Cause:** The **flutter_kokoro_tts** package uses native C/C++ code on Android and requires **CMake 3.18.1** for the NDK build. The Android Gradle plugin looks for CMake in the Android SDK, in `PATH`, or in the `cmake.dir` property; if none of these provide the required version, the build fails.

**Fix:**

1. **Install CMake via Android Studio (recommended)**  
   - Open **Android Studio** → **Settings** (or **Preferences** on macOS) → **Languages & Frameworks** → **Android SDK**.  
   - Open the **SDK Tools** tab.  
   - Enable **Show Package Details**, then under **NDK** ensure a compatible NDK is installed.  
   - Under **CMake**, check **3.18.1** (or a compatible version) and apply.  
   - Ensure your `ANDROID_HOME` / `ANDROID_SDK_ROOT` points to this SDK so Flutter/Gradle can find CMake.

2. **Or install CMake system-wide**  
   - Install CMake 3.18.1 (or newer) on your machine and add it to `PATH` so the build can find it.

After installing CMake, run `flutter clean` and then `flutter run` (or build again).

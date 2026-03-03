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

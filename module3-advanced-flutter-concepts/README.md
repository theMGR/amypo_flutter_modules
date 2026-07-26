# Module 3 — Advanced Flutter Concepts

See [PLAN.md](PLAN.md) for the full 14-hour session breakdown.

## Running the project

Requires the Flutter SDK (`flutter --version` to check).

```
flutter pub get
flutter run -d windows       # or: flutter run -d chrome / any connected device
flutter test                 # verifies every screen renders and core interactions work
flutter analyze              # static analysis
```

`lib/main.dart` shows a home menu linking to each session's demo screen
(`lib/screens/01_*.dart` … `05_*.dart`), numbered to match `PLAN.md`.
`lib/bloc/counter_bloc.dart` holds the Session 4 BLoC implementation
(events, bloc, state) kept separate from its screen's UI code.

## A note on Session 5 (platform-specific features) and testing

`battery_plus` and `device_info_plus` call real platform channels. On some
hosts, `flutter test`'s headless harness has no native plugin registrant and
no default mock for these channels — a call can hang forever (never resolve,
never throw) instead of raising the usual `MissingPluginException`. The
screen protects against this with a `.timeout()` + fallback message, and
`test/widget_test.dart` mocks both channels (and the custom channel below)
with `setMockMethodCallHandler` so the test suite stays fast and
deterministic. The interactive `Clipboard`/`HapticFeedback` buttons on that
screen are left untapped by the automated tests for the same reason — verify
them manually with `flutter run`.

## Session 5's custom platform channel

`lib/native/native_features_channel.dart` (Dart) +
`android/app/src/main/java/com/training/module3_advanced_flutter/MainActivity.java`
(Java) together implement a hand-written channel for battery
**temperature** — something no existing plugin exposes. Only the Android
side is implemented (that's the point: a custom channel only needs native
code for the platform(s) you actually target). To see it return a real
value, run on an Android device or emulator:

```
flutter run -d <android-device-id>
```

On Windows/web/iOS the screen shows "not available on this platform/device"
for that row, since there's no native implementation registered there.

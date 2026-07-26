# Module 1 — Introduction to Mobile App Development and Platforms (Flutter & Dart)

See [PLAN.md](PLAN.md) for the full 12-hour session breakdown.

## Session 1 — Mobile app development & cross-platform frameworks (1.5 hrs, conceptual)

### Native vs cross-platform
- **Native (Android/Kotlin, iOS/Swift):** best performance and platform API access, but separate codebases and teams per platform.
- **Cross-platform:** one codebase targets multiple platforms.
  - **Flutter** (Dart) — compiles to native ARM/x64 code; renders its own UI via a graphics engine (Skia/Impeller), so widgets look identical across platforms.
  - **React Native** (JavaScript) — bridges to native UI components.
  - **Xamarin/.NET MAUI** (C#) — compiles to native, uses native UI controls.

### Why Flutter
1. **Single codebase** for Android, iOS, web, desktop.
2. **Own rendering engine** → pixel-perfect consistency, no reliance on native widget bridges.
3. **Hot reload** → sub-second iteration during development.
4. **Everything is a widget** → declarative UI composition, easy to reason about.

### Flutter's role in the stack
Flutter is the **UI/application framework**. Dart is the **programming language** it's written in and that you write your app logic in. Understanding Dart (Sessions 2–7 in this module) is a prerequisite for writing any Flutter code — Module 2 builds the widgets on top of the language fundamentals covered here.

## Running the code (Sessions 2–8)

Requires the Dart SDK (`dart --version` to check).

```
dart pub get
dart run bin/main.dart               # runs every topic demo end to end
dart run exercises/solutions.dart    # runs the worked exercise answers
```

Each file under `lib/` is self-contained and mirrors one row of the session table in PLAN.md — open them in the order listed while teaching.

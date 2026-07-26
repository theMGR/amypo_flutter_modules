# Module 2 — Flutter Fundamentals: Layouts and UI/UX Concepts

See [PLAN.md](PLAN.md) for the full 10-hour session breakdown and the
expanded list of widgets covered beyond the base syllabus (buttons, inputs,
lists/grids, navigation/structure widgets).

## Session 1 — Introduction to Flutter framework (conceptual, ~1 hr)

- `MaterialApp` is the root widget: sets up theming and hosts the widget tree.
- `Scaffold` gives a screen its standard structure: `AppBar`, `body`,
  optional `drawer` / `floatingActionButton` / `bottomNavigationBar`.
- **Widget tree**: everything in Flutter is a widget; a screen is a tree of
  widgets nested inside each other, and `build()` re-runs top-down whenever
  state changes.
- **Hot reload**: inject code changes into a running app without losing
  state — the fast iteration loop that makes Flutter development quick.

Open `lib/main.dart` and walk through `Module2App` and `HomeMenuScreen`
while teaching this session.

## Running the project (Sessions 2–8)

Requires the Flutter SDK (`flutter --version` to check).

```
flutter pub get
flutter run             # launches on a connected device/emulator/Chrome
flutter test            # runs the smoke tests for every screen
flutter analyze         # static analysis
```

`lib/main.dart` shows a home menu linking to each session's demo screen
(`lib/screens/02_*.dart` … `09_*.dart`), numbered to match `PLAN.md`.
Session 9 is supplementary enrichment covering more widgets used constantly
in real apps (forms/validation, dropdowns, tabs, expansion tiles, tooltips,
popup menus, data tables, page views, bottom sheets, date pickers) — see
`PLAN.md` for details.

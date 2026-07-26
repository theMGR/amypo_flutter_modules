// Session 1 — Overview of mobile app development and cross-platform
// frameworks (conceptual). Full notes: see README.md.

void runOverview() {
  print('\n--- 01: Mobile App Development & Cross-Platform Frameworks ---');

  print('Native vs cross-platform:');
  print('  - Native (Kotlin/Android, Swift/iOS): best performance & platform');
  print('    API access, but separate codebases per platform.');
  print('  - Cross-platform: one codebase targets multiple platforms.');

  final frameworks = {
    'Flutter': 'Dart; own rendering engine (Skia/Impeller); pixel-perfect UI',
    'React Native': 'JavaScript; bridges to native UI components',
    'Xamarin/.NET MAUI': 'C#; compiles to native, uses native UI controls',
  };
  frameworks.forEach((name, detail) => print('  - $name: $detail'));

  print('Why Flutter:');
  final reasons = [
    'Single codebase for Android, iOS, web, desktop',
    'Own rendering engine — consistent UI across platforms',
    'Hot reload for sub-second iteration during development',
    'Everything is a widget — declarative UI composition',
  ];
  for (final r in reasons) {
    print('  - $r');
  }

  print("Flutter's role: it is the UI/application framework. Dart is the");
  print('language it is written in and that you write app logic in —');
  print('Sessions 2-8 of this module build that Dart foundation.');
}

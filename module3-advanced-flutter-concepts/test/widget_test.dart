// Smoke tests: the home menu lists every demo screen, and each screen
// builds and its core interaction works.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:module3_advanced_flutter/main.dart';

void main() {
  // battery_plus/device_info_plus call real platform channels with no
  // native responder under the headless `flutter test` harness on this
  // host, which otherwise hangs the call forever (never resolves, never
  // throws) instead of the usual MissingPluginException. Mocking an
  // immediate reply lets the screen's own Future.timeout() cancel its
  // internal Timer as soon as the (mocked) call completes, so no Timer
  // leaks past test teardown.
  const batteryChannel = MethodChannel('dev.fluttercommunity.plus/battery');
  const deviceInfoChannel = MethodChannel('dev.fluttercommunity.plus/device_info');
  // The custom native_features channel (Session 5's hand-written
  // MethodChannel) has no implementation registered at all on this test
  // host (that's expected — it only has a real Android/Java side), so it
  // must be mocked here too, otherwise it hangs and leaks its Timer just
  // like the plugin channels above.
  const nativeFeaturesChannel = MethodChannel('com.training.module3/native_features');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(batteryChannel, (call) async => 80);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(deviceInfoChannel, (call) async => <String, Object?>{'model': 'Test Device'});
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(nativeFeaturesChannel, (call) async => 29.5);
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(batteryChannel, null);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(deviceInfoChannel, null);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(nativeFeaturesChannel, null);
  });

  testWidgets('Home menu lists all 5 demo screens', (WidgetTester tester) async {
    await tester.pumpWidget(const Module3App());

    expect(find.text('01 - Navigation & Routing'), findsOneWidget);
    expect(find.text('02 - Theming & Customization'), findsOneWidget);
    expect(find.text('03 - Animations & Transitions'), findsOneWidget);
    expect(find.text('04 - BLoC State Management'), findsOneWidget);
    expect(find.text('05 - Platform-Specific Features'), findsOneWidget);
  });

  Future<void> openScreen(WidgetTester tester, String title) async {
    await tester.pumpWidget(const Module3App());
    await tester.ensureVisible(find.text(title));
    await tester.pumpAndSettle();
    await tester.tap(find.text(title));
    await tester.pumpAndSettle();
  }

  testWidgets('01 - navigation pushes a named route with args and returns a result', (tester) async {
    await openScreen(tester, '01 - Navigation & Routing');

    await tester.tap(find.text('Push named route with arguments'));
    await tester.pumpAndSettle();
    expect(find.text('Profile: Asha'), findsOneWidget);
    expect(find.text('userId = 42'), findsOneWidget);

    await tester.tap(find.text('Pop with a result'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Returned: Saved changes for Asha'), findsOneWidget);
  });

  testWidgets('02 - theming screen toggles ThemeMode via SegmentedButton', (tester) async {
    await openScreen(tester, '02 - Theming & Customization');
    expect(find.text('Current ThemeMode: system'), findsOneWidget);

    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();
    expect(find.text('Current ThemeMode: dark'), findsOneWidget);
  });

  testWidgets('03 - animations screen expands AnimatedContainer on tap', (tester) async {
    await openScreen(tester, '03 - Animations & Transitions');
    expect(find.text('Tap me'), findsOneWidget);

    await tester.tap(find.text('Tap me'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    // Just confirm no exception was thrown driving the animation.
    expect(find.text('Tap me'), findsOneWidget);
  });

  testWidgets('03 - Hero animation navigates to detail screen', (tester) async {
    await openScreen(tester, '03 - Animations & Transitions');
    await tester.tap(find.byKey(const Key('hero-thumbnail-tap-target')));
    await tester.pumpAndSettle();
    expect(find.text('Hero Detail'), findsOneWidget);
  });

  testWidgets('04 - BLoC counter increments/decrements/resets via events', (tester) async {
    await openScreen(tester, '04 - BLoC State Management');
    expect(find.text('Count: 0'), findsOneWidget);

    await tester.tap(find.text('+'));
    await tester.pump();
    expect(find.text('Count: 1'), findsOneWidget);

    await tester.tap(find.text('+'));
    await tester.pump();
    expect(find.text('Count: 2'), findsOneWidget);

    await tester.tap(find.text('-'));
    await tester.pump();
    expect(find.text('Count: 1'), findsOneWidget);

    await tester.tap(find.text('Reset'));
    await tester.pump();
    expect(find.text('Count: 0'), findsOneWidget);
  });

  testWidgets('05 - platform features resolve via mocked channels', (tester) async {
    await openScreen(tester, '05 - Platform-Specific Features');
    await tester.pumpAndSettle();

    expect(find.textContaining('Battery level: 80%'), findsOneWidget);
    // device_info_plus parses the raw channel map into a strongly-typed
    // WindowsDeviceInfo, which our minimal mock map doesn't fully satisfy —
    // so we only assert it moved past the loading state, not the exact value.
    expect(find.textContaining('Reading device info'), findsNothing);
    expect(find.textContaining('Device model:'), findsOneWidget);
    expect(find.textContaining('Battery temperature: 29.5°C'), findsOneWidget);

    // Clipboard is a built-in flutter/services.dart channel; flutter_test's
    // default binary messenger does not mock it on this host either, so it
    // is intentionally left untapped here and verified manually via
    // `flutter run` instead.
    expect(find.text('Copy text'), findsOneWidget);
    expect(find.text('Trigger haptic feedback'), findsOneWidget);
  });
}

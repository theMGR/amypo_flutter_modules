// Smoke tests: the home menu lists every demo screen, and each screen
// pushes and builds without throwing.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:module2_flutter_fundamentals/main.dart';

void main() {
  testWidgets('Home menu lists all 7 demo screens', (WidgetTester tester) async {
    await tester.pumpWidget(const Module2App());

    expect(find.text('02 - Stateless vs Stateful'), findsOneWidget);
    expect(find.text('03 - Layout techniques'), findsOneWidget);
    expect(find.text('04 - Text, Image, Icon'), findsOneWidget);
    expect(find.text('05 - Buttons'), findsOneWidget);
    expect(find.text('06 - Inputs & Lists'), findsOneWidget);
    expect(find.text('07 - Navigation & Structure'), findsOneWidget);
    expect(find.text('08 - State Management'), findsOneWidget);
    expect(find.text('09 - More Common Widgets'), findsOneWidget);
  });

  Future<void> openScreen(WidgetTester tester, String title) async {
    await tester.pumpWidget(const Module2App());
    await tester.ensureVisible(find.text(title));
    await tester.pumpAndSettle();
    await tester.tap(find.text(title));
    await tester.pumpAndSettle();
  }

  testWidgets('02 - tapping the stateful card increments its counter', (tester) async {
    await openScreen(tester, '02 - Stateless vs Stateful');
    expect(find.text('Stateful: tapped 0 times'), findsOneWidget);
    await tester.tap(find.text('Tap me'));
    await tester.pump();
    expect(find.text('Stateful: tapped 1 times'), findsOneWidget);
  });

  testWidgets('03 - layouts screen builds', (tester) async {
    await openScreen(tester, '03 - Layout techniques');
    expect(find.text('Container with padding + decoration'), findsOneWidget);
  });

  testWidgets('04 - text/image/icon screen builds', (tester) async {
    await openScreen(tester, '04 - Text, Image, Icon');
    expect(find.text('Jane Doe'), findsOneWidget);
  });

  testWidgets('05 - buttons screen increments shared counter via FAB', (tester) async {
    await openScreen(tester, '05 - Buttons');
    expect(find.textContaining('Counter: 0'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.textContaining('Counter: 1'), findsOneWidget);
  });

  testWidgets('06 - inputs & lists screen adds a to-do item', (tester) async {
    await openScreen(tester, '06 - Inputs & Lists');
    expect(find.text('Buy milk'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Write more tests');
    await tester.tap(find.text('Add'));
    await tester.pump();
    expect(find.text('Write more tests'), findsOneWidget);
  });

  testWidgets('07 - navigation screen pushes a detail screen and returns a result', (tester) async {
    await openScreen(tester, '07 - Navigation & Structure');
    await tester.tap(find.text('Push detail screen (returns a result)'));
    await tester.pumpAndSettle();
    expect(find.text('Detail Screen'), findsOneWidget);

    await tester.tap(find.text('Pop with a result'));
    await tester.pumpAndSettle();
    expect(find.text('Result from detail screen: Hello from DetailScreen'), findsOneWidget);
  });

  testWidgets('08 - state management screen shares one counter across two children', (tester) async {
    await openScreen(tester, '08 - State Management');
    expect(find.text('Shared count: 0'), findsOneWidget);
    await tester.tap(find.text('+'));
    await tester.pump();
    expect(find.text('Shared count: 1'), findsOneWidget);
    await tester.tap(find.text('-'));
    await tester.pump();
    expect(find.text('Shared count: 0'), findsOneWidget);
  });

  testWidgets('09 - form validation and dropdown work', (tester) async {
    await openScreen(tester, '09 - More Common Widgets');

    // Form validation tab (default selected tab).
    await tester.tap(find.text('Validate'));
    await tester.pump();
    expect(find.text('Fix the errors above'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'not-an-email');
    await tester.tap(find.text('Validate'));
    await tester.pump();
    expect(find.text('Enter a valid email'), findsOneWidget);

    // DropdownButton default value is visible.
    expect(find.text('India'), findsOneWidget);

    // Switch to the Display & Misc tab and expand the ExpansionTile.
    await tester.tap(find.text('Display & Misc'));
    await tester.pumpAndSettle();
    expect(find.text('Tap to expand'), findsOneWidget);
    await tester.tap(find.text('Tap to expand'));
    await tester.pumpAndSettle();
    expect(find.text('Hidden content revealed.'), findsOneWidget);
  });
}

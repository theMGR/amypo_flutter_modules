import '../lib/01_overview.dart';
import '../lib/02_variables_datatypes.dart';
import '../lib/03_operators.dart';
import '../lib/04_control_flow.dart';
import '../lib/05_functions.dart';
import '../lib/06_classes_objects.dart';
import '../lib/07_async_futures.dart';

Future<void> main() async {
  print('Module 1 — Introduction to Mobile App Development and Dart');

  runOverview();
  runVariablesAndDataTypes();
  runOperators();
  runControlFlow();
  runFunctions();
  runClassesAndObjects();
  await runAsyncFutures();

  print('\nAll Module 1 demos complete.');
}

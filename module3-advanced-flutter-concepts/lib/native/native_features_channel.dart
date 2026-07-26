import 'package:flutter/services.dart';

// Session 5 — the Dart half of a hand-written platform channel. Unlike
// battery_plus/device_info_plus (existing plugins), THIS functionality
// (battery temperature) has no plugin, so we write the channel ourselves.
// The Android/Java implementation lives in
// android/app/src/main/java/.../MainActivity.java — that's the piece that
// actually reads the value from the OS and answers this channel's calls.
// There is intentionally no iOS/Windows/web implementation registered for
// this channel, which is the normal state for a channel written for one
// specific platform's capability.
class NativeFeaturesChannel {
  static const _channel = MethodChannel('com.training.module3/native_features');
  static const _callTimeout = Duration(seconds: 3);

  /// Returns the battery temperature in Celsius, or null if unavailable
  /// (e.g. running on a platform/emulator with no native implementation).
  static Future<double?> getBatteryTemperatureCelsius() async {
    try {
      final result = await _channel
          .invokeMethod<double>('getBatteryTemperatureCelsius')
          .timeout(_callTimeout);
      return result;
    } on MissingPluginException {
      return null; // no native implementation registered for this platform
    } on PlatformException {
      return null; // native side reported the value isn't available
    } catch (_) {
      return null; // e.g. TimeoutException in a headless/test environment
    }
  }
}

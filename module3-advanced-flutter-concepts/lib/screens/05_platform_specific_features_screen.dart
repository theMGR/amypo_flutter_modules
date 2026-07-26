import 'package:battery_plus/battery_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../native/native_features_channel.dart';

// Session 5 — Platform-specific features: accessing device/native
// functionality through plugins. A Flutter plugin exposes a Dart API that,
// under the hood, sends a message across a platform channel to native code
// (Kotlin/Java on Android, Swift/Obj-C on iOS, C++/C# elsewhere) and
// returns the native result back to Dart.
//
// Each lookup is wrapped in try/catch: on a platform/environment where the
// underlying channel isn't available (e.g. a headless test harness), we
// show a fallback message instead of crashing — the same defensive pattern
// you'd use for a feature that's only available on some platforms.

// A platform channel call to a plugin that isn't wired up on the current
// host (e.g. no native implementation, or a headless test harness with no
// plugin registrant) can hang forever instead of throwing — so every call
// gets a timeout and a graceful fallback rather than blocking the UI.
const _platformCallTimeout = Duration(seconds: 3);

Future<String> _readBatteryLevel() async {
  try {
    final level = await Battery().batteryLevel.timeout(_platformCallTimeout);
    return '$level%';
  } catch (e) {
    return 'unavailable in this environment ($e)';
  }
}

Future<String> _readDeviceModel() async {
  try {
    final plugin = DeviceInfoPlugin();
    final info = await plugin.deviceInfo.timeout(_platformCallTimeout);
    return info.data['model']?.toString() ?? info.data.toString();
  } catch (e) {
    return 'unavailable in this environment ($e)';
  }
}

Future<String> _readBatteryTemperature() async {
  final celsius = await NativeFeaturesChannel.getBatteryTemperatureCelsius();
  return celsius == null ? 'not available on this platform/device' : '$celsius°C';
}

class PlatformSpecificFeaturesScreen extends StatefulWidget {
  const PlatformSpecificFeaturesScreen({super.key});

  @override
  State<PlatformSpecificFeaturesScreen> createState() => _PlatformSpecificFeaturesScreenState();
}

class _PlatformSpecificFeaturesScreenState extends State<PlatformSpecificFeaturesScreen> {
  late Future<String> _batteryFuture;
  late Future<String> _deviceFuture;
  late Future<String> _batteryTemperatureFuture;
  String _clipboardStatus = '';

  @override
  void initState() {
    super.initState();
    _batteryFuture = _readBatteryLevel();
    _deviceFuture = _readDeviceModel();
    _batteryTemperatureFuture = _readBatteryTemperature();
  }

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(const ClipboardData(text: 'Hello from Module 3!'));
    setState(() => _clipboardStatus = 'Copied "Hello from Module 3!" to the clipboard');
  }

  Future<void> _readClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    setState(() => _clipboardStatus = 'Clipboard contains: ${data?.text ?? '(empty)'}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('05 - Platform-Specific Features')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Plugin: battery_plus', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          FutureBuilder<String>(
            future: _batteryFuture,
            builder: (context, snapshot) => Text(
              snapshot.connectionState == ConnectionState.waiting
                  ? 'Reading battery level...'
                  : 'Battery level: ${snapshot.data}',
            ),
          ),
          const SizedBox(height: 24),

          const Text('Plugin: device_info_plus', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          FutureBuilder<String>(
            future: _deviceFuture,
            builder: (context, snapshot) => Text(
              snapshot.connectionState == ConnectionState.waiting
                  ? 'Reading device info...'
                  : 'Device model: ${snapshot.data}',
            ),
          ),
          const SizedBox(height: 24),

          const Text('Custom platform channel: battery temperature (no plugin covers this)',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const Text(
            'Hand-written channel "com.training.module3/native_features" — '
            'Android/Java implementation in MainActivity.java reads it via '
            'BatteryManager; no iOS/Windows/web side is implemented.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          FutureBuilder<String>(
            future: _batteryTemperatureFuture,
            builder: (context, snapshot) => Text(
              snapshot.connectionState == ConnectionState.waiting
                  ? 'Reading battery temperature...'
                  : 'Battery temperature: ${snapshot.data}',
            ),
          ),
          const SizedBox(height: 24),

          const Text('Built-in platform channel: Clipboard (flutter/services.dart)',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton(onPressed: _copyToClipboard, child: const Text('Copy text')),
              const SizedBox(width: 12),
              ElevatedButton(onPressed: _readClipboard, child: const Text('Read clipboard')),
            ],
          ),
          if (_clipboardStatus.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(_clipboardStatus),
          ],
          const SizedBox(height: 24),

          const Text('Built-in platform channel: HapticFeedback', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => HapticFeedback.mediumImpact(),
            child: const Text('Trigger haptic feedback'),
          ),
        ],
      ),
    );
  }
}

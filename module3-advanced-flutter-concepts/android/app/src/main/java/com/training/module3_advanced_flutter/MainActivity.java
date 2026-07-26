package com.training.module3_advanced_flutter;

import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

// Session 5 — a hand-written platform channel for functionality no existing
// plugin exposes: battery TEMPERATURE (battery_plus only gives you charge
// level). The Dart side is lib/native/native_features_channel.dart; this is
// the Android/Java half that actually answers the channel call.
public class MainActivity extends FlutterActivity {
    private static final String CHANNEL_NAME = "com.training.module3/native_features";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL_NAME)
                .setMethodCallHandler((call, result) -> {
                    if (call.method.equals("getBatteryTemperatureCelsius")) {
                        Double temperature = readBatteryTemperatureCelsius();
                        if (temperature != null) {
                            result.success(temperature);
                        } else {
                            result.error(
                                    "UNAVAILABLE",
                                    "Battery temperature is not available on this device",
                                    null);
                        }
                    } else {
                        result.notImplemented();
                    }
                });
    }

    @Nullable
    private Double readBatteryTemperatureCelsius() {
        Intent batteryIntent = registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
        int tenthsOfCelsius = batteryIntent != null
                ? batteryIntent.getIntExtra(BatteryManager.EXTRA_TEMPERATURE, -1)
                : -1;
        return tenthsOfCelsius >= 0 ? tenthsOfCelsius / 10.0 : null;
    }
}

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:system_theme/system_theme.dart';

void main() {
  const MethodChannel channel = MethodChannel('system_theme');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (methodCall) async {
      switch (methodCall.method) {
        case kGetSystemAccentColorMethod:
          return kDefaultFallbackColor.toString();
        case kGetDarkModeMethod:
          return false;
        default:
          return null;
      }
    });
  });

  test('Get accent color', () async {
    final color = await channel.invokeMethod(kGetSystemAccentColorMethod);
    expect(kDefaultFallbackColor.toString(), color);
  });

  test('Check dark mode', () async {
    final darkMode = await channel.invokeMethod(kGetDarkModeMethod);
    expect(false, darkMode);
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });
}

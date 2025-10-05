import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class ApiConfig {
  static String? _cachedBaseUrl;

  /// Detecta si es emulador o celular físico y devuelve la URL correcta
  static Future<String> getBaseUrl() async {
    if (_cachedBaseUrl != null) return _cachedBaseUrl!;

    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;

      if (androidInfo.isPhysicalDevice) {
        // 👉 si es Android físico usa la IP local de tu PC
        _cachedBaseUrl = "http://192.168.1.76:3000/API/v1";
      } else {
        // 👉 si es emulador Android
        _cachedBaseUrl = "http://10.0.2.2:3000/API/v1";
      }
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;

      if (iosInfo.isPhysicalDevice) {
        // 👉 iPhone físico
        _cachedBaseUrl = "http://192.168.1.100:3000/API/v1"; 
      } else {
        // 👉 simulador iOS
        _cachedBaseUrl = "http://localhost:3000/API/v1";
      }
    } else {
      // 👉 fallback para web o desktop
      _cachedBaseUrl = "http://localhost:3000/API/v1";
    }

    return _cachedBaseUrl!;
  }
}

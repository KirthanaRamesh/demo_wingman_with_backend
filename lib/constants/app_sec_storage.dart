
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppSecureStorage {
  final storage = const FlutterSecureStorage();
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<bool> containsKey(String key) {
    return storage.containsKey(key: key, aOptions: _getAndroidOptions());
  }

  void writeData(String key, String value) {
    storage.write(key: key, value: value, aOptions: _getAndroidOptions());
  }

  Future deleteValue(String key) async {
    await storage.delete(key: key, aOptions: _getAndroidOptions());
  }

  Future readData(String key) async {
    return await storage.read(key: key, aOptions: _getAndroidOptions());
  }
}

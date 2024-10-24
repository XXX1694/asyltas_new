import 'package:shared_preferences/shared_preferences.dart';

/// Provides access to platform local storage.
class LocalStorage {
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  int getInt(String key, {int defaultValue = 0}) {
    return _prefs!.getInt(key) ?? defaultValue;
  }

  Future<void> putInt(String key, int value) async {
    await init();
    await _prefs!.setInt(key, value);
  }

  String? getString(String key, {String? defaultValue}) {
    return _prefs!.getString(key) ?? defaultValue;
  }

  Future<void> putString(String key, String value) async {
    await init();
    await _prefs!.setString(key, value);
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs!.getBool(key) ?? defaultValue;
  }

  Future<void> putBool(String key, bool value) async {
    await init();
    await _prefs!.setBool(key, value);
  }

  double getDouble(String key, {double defaultValue = 0.0}) {
    return _prefs!.getDouble(key) ?? defaultValue;
  }

  Future<void> putDouble(String key, double value) async {
    await init();
    await _prefs!.setDouble(key, value);
  }

  List<String>? getStringList(String key, {List<String>? defaultValue}) {
    return _prefs!.getStringList(key) ?? defaultValue;
  }

  Future<void> putStringList(String key, List<String> value) async {
    await init();
    await _prefs!.setStringList(key, value);
  }

  Future<void> remove(String key) async {
    await init();
    await _prefs!.remove(key);
  }
}

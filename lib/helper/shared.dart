import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class MyCache {
  static SharedPreferences? preferences;
  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static void setString({required MyChachKey key, required String value}) {
    preferences?.setString(key.name, value);
    print("success $value");
  }
  static String getString({required MyChachKey key}) {
    return preferences?.getString(key.name) ?? "";
  }


  static void setInt({required MyChachKey key, required int value}) {
    preferences?.setInt(key.name, value);
  }
  static int GetInt({required MyChachKey key}) {
    return preferences?.getInt(key.name) ?? 0;
  }


  static void SetBool({required MyChachKey key, required bool value}) {
    preferences?.setBool(key.name, value);
  }
  static bool? GetBool({required MyChachKey key}) {
    return preferences?.getBool(key.name)?? false;
  }


  static void SetDouble({required MyChachKey key, required double value}) {
    preferences?.setDouble(key.name, value);
  }
  static double? GetDouble({required MyChachKey key}) {
    return preferences?.getDouble(key.name)?? 0.0;
  }

}
enum MyChachKey{

  email,
  password,
  name,
  checked,
  onBoarding,
  token,
  userId,
  faveList
}
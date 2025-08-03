import 'package:shared_preferences/shared_preferences.dart';

class SharePrefUtils {
  late Future<SharedPreferences> sharedPref;

  SharePrefUtils({Future<SharedPreferences>? sharedPreferences}) {
    sharedPref = sharedPreferences ?? SharedPreferences.getInstance();
  }

  Future<bool> setString(String key, String value) async {
    final SharedPreferences prefs = await sharedPref;
    return prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final SharedPreferences prefs = await sharedPref;
    return prefs.getString(key);
  }

  Future<bool> remove(String key) async {
    final SharedPreferences prefs = await sharedPref;
    return prefs.remove(key);
  }
}

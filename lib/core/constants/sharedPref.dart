import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{
  static Future<void> setLogged(bool isLogged) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setBool('isLogged', isLogged);
  }

  static Future<bool> getLogged() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getBool('isLogged') ?? false;
  }
}
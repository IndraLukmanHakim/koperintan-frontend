import 'package:shared_preferences/shared_preferences.dart';

class SplashService {
  SharedPreferences? sharedPreferences;

  Future<bool> initSharedData() {
    if (!sharedPreferences!.containsKey('token')) {
      return sharedPreferences!.setString('token', '');
    }
    return Future.value(true);
  }

  Future<bool> removeSharedData() {
    return sharedPreferences!.clear();
  }
}

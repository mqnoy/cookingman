import 'package:shared_preferences/shared_preferences.dart';

class LocalRepo {
  final SharedPreferences sharedPreferences;

  LocalRepo({required this.sharedPreferences});
}
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static String? accessToken;

  final String _accessTokenKey = 'access-token';

  Future<void> saveAccessToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('access-token', token);
    accessToken = token;
  }

  Future<String?> getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString(_accessTokenKey);
    accessToken = token;
    return token;
  }

  //is User logged in?

  Future<bool> isLoggedInUser() async{
    return accessToken != null;
  }

}
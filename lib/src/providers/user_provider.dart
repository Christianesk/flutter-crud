import 'dart:convert';

import 'package:flutter_crud/src/config/config.dart';
import 'package:flutter_crud/src/user_preferences/user_preferences.dart';
import 'package:http/http.dart' as http;

class UserProvider {

  final _prefs = new UserPreferences();

  Future<Map<String, dynamic>> createUser(String email, String password)  {
    return  handleAuth(urlSignUp, email, password);
  }

  Future<Map<String, dynamic>> login(String email, String password) {
    return  handleAuth(urlLogin, email, password);
  }

  Future<Map<String, dynamic>> handleAuth(String url,String email, String password) async{
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(url, body: json.encode(authData));

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      _prefs.token = decodedResp['idToken'];
      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      return {'ok': false, 'message': decodedResp['error']['message']};
    }
  }
}

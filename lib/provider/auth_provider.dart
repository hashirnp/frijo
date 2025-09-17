import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:noviindus/controller/auth_controller.dart';
import 'package:noviindus/core/constants/app_constants.dart';
import 'package:noviindus/injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final AuthController _controller = getIt<AuthController>();

  bool _loading = false;
  bool get loading => _loading;

  bool _isAuth = false;
  bool get isAuth => _isAuth;

  bool _loginFailed = false;
  bool get loginFailed => _loginFailed;

  String? _token;
  String? get token => _token;

  String _email = "";
  String _password = "";

  String get email => _email;
  String get password => _password;

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> login({required String mobileNumber}) async {
    _loginFailed = false;
    setLoading(true);

    try {
      final responseData = await _controller.login(
        mobileNumber: mobileNumber,
        countryCode: '+91',
      );
      if (responseData.containsKey('token')) {
        _token = responseData['token']['access'];
        await getIt<SharedPreferences>().setString(AppConstants.token, _token!);
        _isAuth = true;
      } else {
        _isAuth = false;
        _loginFailed = true;
        throw Exception("Token not found in response");
      }
    } catch (e, st) {
      _isAuth = false;
      _loginFailed = true;
      log("Login error: $e", stackTrace: st);
    }

    // _isAuth = true;
    setLoading(false);
  }

  Future<bool> logout() async {
    _isAuth = false;
    _token = null;

    getIt<SharedPreferences>().clear();

    notifyListeners();
    return true;
  }

  setLoginStatus(bool val) {
    _loginFailed = val;
    notifyListeners();
  }
}

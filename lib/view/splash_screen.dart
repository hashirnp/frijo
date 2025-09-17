import 'package:flutter/material.dart';
import 'package:noviindus/core/constants/app_constants.dart';
import 'package:noviindus/injection.dart';
import 'package:noviindus/routes/routnames.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() async {
    await Future.delayed(const Duration(seconds: 1));

    final prefs = getIt<SharedPreferences>();
    final token = prefs.getString(AppConstants.token);

    String nextScreen = (token == null) ? RouteNames.login : RouteNames.home;

    getIt<NavigationService>().navigatorkey.currentState!
        .pushNamedAndRemoveUntil(nextScreen, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: FlutterLogo(size: 120)));
  }
}

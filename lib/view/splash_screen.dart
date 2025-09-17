import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noviindus/core/constants/app_constants.dart';
import 'package:noviindus/injection.dart';
import 'package:noviindus/routes/routnames.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    _navigate();
  }

  void _navigate() async {
    await Future.delayed(const Duration(seconds: 3));

    final prefs = getIt<SharedPreferences>();
    final token = prefs.getString(AppConstants.token);

    String nextScreen = (token == null) ? RouteNames.login : RouteNames.home;

    getIt<NavigationService>().navigatorkey.currentState!
        .pushNamedAndRemoveUntil(nextScreen, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          // height: 120,
          width: 120,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppConstants.red),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "F",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  color: AppConstants.red,

                  fontSize: 100,
                ),
              ),
              Text(
                "FRIJO",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  color: AppConstants.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

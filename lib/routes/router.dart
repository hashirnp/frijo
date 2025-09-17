import 'package:flutter/material.dart';
import 'package:noviindus/routes/routnames.dart';
import 'package:noviindus/view/Auth/login_screen.dart';
import 'package:noviindus/view/Upload/upload_video_screen.dart';
import 'package:noviindus/view/home/home_screen.dart';
import 'package:noviindus/view/splash_screen.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case RouteNames.addVideo:
        return MaterialPageRoute(builder: (_) => const UploadVideoScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

class ChatPageArguments {
  String appId;
  int? bookId;
  bool isCallAvailable;
  bool? isDirectToCall;
  bool? isPipModeActive;

  String? roomId;
  int? docId;
  bool? isfinished;
  ChatPageArguments({
    required this.appId,
    required this.docId,
    required this.isCallAvailable,
    this.isPipModeActive,
    this.isDirectToCall,
    required this.bookId,
  });
}

class BookingScreenArguments {
  int specialityId;
  int? subCatId;
  int? subspecialityId;
  int? psychologyType;
  String itemName;
  // bool? pkgAvailability;

  BookingScreenArguments({
    required this.specialityId,
    required this.itemName,
    required this.subCatId,
    this.subspecialityId,
    this.psychologyType,
  });
}

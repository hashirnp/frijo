import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:frijo/controller/auth_controller.dart';
import 'package:frijo/controller/feed_controller.dart';
import 'package:frijo/provider/auth_provider.dart';
import 'package:frijo/provider/feed_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/dio_client.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());

  getIt.registerSingleton<DioClient>(DioClient());

  getIt.registerSingleton<AuthController>(AuthController(getIt<DioClient>()));
  getIt.registerSingleton<FeedController>(FeedController(getIt<DioClient>()));

  getIt.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  getIt.registerSingleton<AuthProvider>(AuthProvider());
  getIt.registerSingleton<FeedProvider>(FeedProvider());
}

class NavigationService {
  final GlobalKey<NavigatorState> navigatorkey = GlobalKey<NavigatorState>();
  dynamic pushTo(String route, {dynamic arguments}) {
    return navigatorkey.currentState?.pushNamed(route, arguments: arguments);
  }

  dynamic goBack() {
    return navigatorkey.currentState?.pop();
  }
}

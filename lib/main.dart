import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noviindus/provider/auth_provider.dart';
import 'package:noviindus/routes/router.dart';
import 'package:noviindus/routes/routnames.dart';
import 'package:noviindus/view/splash_screen.dart';
import 'package:provider/provider.dart';

import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter is initialized

  await setupLocator(); // ✅ Register dependencies with GetIt
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => getIt<AuthProvider>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyRouteObserver extends NavigatorObserver {
  String? currentRoute;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    currentRoute = route.settings.name;
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    currentRoute = previousRoute?.settings.name;
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    currentRoute = newRoute?.settings.name;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final MyRouteObserver myRouteObserver = MyRouteObserver();

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme().apply(
          bodyColor: Colors.white,
        ),

        scaffoldBackgroundColor: Colors.black,
      ),

      onGenerateRoute: Routers.generateRoute,
      navigatorKey: getIt<NavigationService>().navigatorkey,
      navigatorObservers: [myRouteObserver],
      initialRoute: RouteNames.splash,
      home: const SplashScreen(),
    );
  }
}

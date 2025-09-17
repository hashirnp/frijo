// import 'package:dio/dio.dart';
// import '../constants/app_constants.dart';

// class DioClient {
//   late Dio dio;

//   DioClient() {
//     dio = Dio(
//       BaseOptions(
//         baseUrl: AppConstants.baseUrl,
//         connectTimeout: Duration(milliseconds: AppConstants.connectTimeout),
//         receiveTimeout: Duration(milliseconds: AppConstants.receiveTimeout),
//         responseType: ResponseType.json,
//       ),
//     );
//     dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
//   }

//   Future<Response> get(String endpoint) async => await dio.get(endpoint);

//   Future<Response> post(String endpoint, {dynamic data}) async =>
//       await dio.post(endpoint, data: data);
// }

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frijo/core/constants/app_constants.dart';
import 'package:frijo/injection.dart';
import 'package:frijo/view/splash_screen.dart';

class DioClient {
  String baseUrl = AppConstants.baseUrl;

  post(String endpoint, var data, String? token) async {
    String url = "$baseUrl$endpoint";
    if (kDebugMode) {
      print('url: $url');
      print('data: ${data.toString()}');
      print('token: $token');
    }

    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
        HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
    try {
      if (token == null) {
        Response response = await dio.post(url, data: data);
        log("response ${response.statusCode}");
        if (response.statusCode == 200 ||
            response.statusCode == 201 ||
            response.statusCode == 202) {
          return response.data;
        } else if (response.statusCode == 401) {
          Fluttertoast.showToast(msg: "Unauthorized User");
          Navigator.pushAndRemoveUntil(
            getIt<NavigationService>().navigatorkey.currentContext!,
            MaterialPageRoute(builder: (_) => const SplashScreen()),
            (route) => false,
          );
          return null;
        } else {
          return null;
        }
      }
      Response response = await dio.post(
        url,
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      log("response ${response.statusCode}");

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        return response.data;
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(msg: "Unauthorized User");
        Navigator.pushAndRemoveUntil(
          getIt<NavigationService>().navigatorkey.currentContext!,
          MaterialPageRoute(builder: (_) => const SplashScreen()),
          (route) => false,
        );
      } else {
        return null;
      }
    } catch (e) {
      log('Error: $e');

      if (e is DioException) {
        // Access the response's status code
        final statusCode = e.response?.statusCode;
        if (statusCode == 401) {
          Fluttertoast.showToast(msg: "Unauthorized User");
          Navigator.pushAndRemoveUntil(
            getIt<NavigationService>().navigatorkey.currentContext!,
            MaterialPageRoute(builder: (_) => const SplashScreen()),
            (route) => false,
          );
        }
      } else {
        // Handle other exceptions
        log('Error: $e');
      }
    }
  }

  get(String endpoint, String? token) async {
    String url = "$baseUrl$endpoint";
    if (kDebugMode) {
      print('url: $url');
    }
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
        HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
    try {
      if (token == null) {
        Response response = await dio.get(url);

        if (response.statusCode == 200 ||
            response.statusCode == 201 ||
            response.statusCode == 202) {
          return response.data;
        } else if (response.statusCode == 401) {
          Fluttertoast.showToast(msg: "Unauthorized User");
          Navigator.pushAndRemoveUntil(
            getIt<NavigationService>().navigatorkey.currentContext!,
            MaterialPageRoute(builder: (_) => const SplashScreen()),
            (route) => false,
          );
        } else {
          return null;
        }
      }
      if (token != null) {
        Response response = await dio.get(
          url,
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );

        if (response.statusCode == 200 ||
            response.statusCode == 201 ||
            response.statusCode == 202) {
          return response.data;
        } else {
          return null;
        }
      }
    } catch (e) {
      if (e is DioException) {
        // Access the response's status code
        final statusCode = e.response?.statusCode;
        if (statusCode == 401) {
          Fluttertoast.showToast(msg: "Unauthorized User");
          Navigator.pushAndRemoveUntil(
            getIt<NavigationService>().navigatorkey.currentContext!,
            MaterialPageRoute(builder: (_) => const SplashScreen()),
            (route) => false,
          );
        }
      } else {
        // Handle other exceptions
        // print('Error: $e');
      }
    }
  }
}

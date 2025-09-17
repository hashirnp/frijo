import 'package:dio/dio.dart';
import 'package:noviindus/core/network/api_endpoints.dart';
import 'package:noviindus/core/network/dio_client.dart';

class AuthController {
  final DioClient _client;

  AuthController(this._client);

  Future<Map<String, dynamic>> login({
    required String userName,
    required String password,
  }) async {
    try {
      String endpoint = ApiEndpoints.login;
      final formData = FormData.fromMap({
        "username": userName,
        "password": password,
      });
      dynamic responseData = await _client.post(endpoint, formData, null);
      if (responseData != null && responseData['token'] != null) {
        return responseData;
      } else {
        throw Exception("Invalid response from server");
      }
    } catch (e) {
      rethrow;
    }
  }
}

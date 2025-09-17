import 'dart:developer';

import 'package:noviindus/core/network/dio_client.dart';

class RegistrationController {
  DioClient dioClient;
  RegistrationController(this.dioClient);

  Future<dynamic> fetchPatients(String endpoint, String token) async {
    try {
      final response = await dioClient.get(endpoint, token);
      if (response != null &&
          response["patient"] is List &&
          response['status'] == true) {
        return response;
      } else {
        throw Exception("Invalid response from server");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> fetchBranches(String endpoint, String token) async {
    try {
      final response = await dioClient.get(endpoint, token);
      if (response != null &&
          response["branches"] is List &&
          response['status'] == true) {
        return response;
      } else {
        throw Exception("Invalid response from server");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> fetchTreatments(String endpoint, String token) async {
    try {
      final response = await dioClient.get(endpoint, token);
      if (response != null &&
          response["treatments"] is List &&
          response['status'] == true) {
        return response;
      } else {
        throw Exception("Invalid response from server");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePatients(
    String endpoint,
    dynamic data,
    String token,
  ) async {
    try {
      final response = await dioClient.post(endpoint, data, token);
      log(response.toString());
      if (response != null) {
        return response;
      } else {
        throw Exception("Invalid response from server");
      }
    } catch (e) {
      rethrow;
    }
  }
}

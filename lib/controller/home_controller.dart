import 'package:noviindus/core/network/dio_client.dart';

class HomeController {
  DioClient dioClient;
  HomeController(this.dioClient);

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
}

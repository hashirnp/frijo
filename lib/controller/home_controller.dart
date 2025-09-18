import 'package:frijo/core/constants/app_constants.dart';
import 'package:frijo/core/network/api_endpoints.dart';
import 'package:frijo/core/network/dio_client.dart';
import 'package:frijo/injection.dart';
import 'package:frijo/model/category_response/category_response.dart';
import 'package:frijo/model/video_modal/video_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController {
  DioClient dioClient;
  HomeController(this.dioClient);

  //fetch categories
  Future<CategoryResponse> fetchCategories() async {
    try {
      String endpoint = ApiEndpoints.category; // Example endpoint
      dynamic responseData = await dioClient.get(endpoint, null);
      if (responseData != null) {
        CategoryResponse response = CategoryResponse.fromJson(responseData);
        return response;
      } else {
        throw Exception("Invalid response from server");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<VideoModal>> fetchVideos() async {
    try {
      String endpoint = ApiEndpoints.home; // Example endpoint
      final token = getIt<SharedPreferences>().getString(AppConstants.token);
      dynamic responseData = await dioClient.get(endpoint, token);
      if (responseData != null) {
        List<VideoModal> videos = responseData["results"]
            .map<VideoModal>((json) => VideoModal.fromJson(json))
            .toList();
        return videos;
      } else {
        throw Exception("Invalid response from server");
      }
    } catch (e) {
      rethrow;
    }
  }
}

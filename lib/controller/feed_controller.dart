import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:noviindus/core/constants/app_constants.dart';
import 'package:noviindus/core/network/api_endpoints.dart';
import 'package:noviindus/core/network/dio_client.dart';
import 'package:noviindus/injection.dart';
import 'package:noviindus/model/category_response/category_response.dart';
import 'package:noviindus/model/video_modal/video_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedController {
  DioClient dioClient;
  FeedController(this.dioClient);

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

  Future<bool> sharePost({
    required String description,
    required String videoPath,
    required String thumbnailPath,
    required List<int> categoryIds,
  }) async {
    try {
      String endpoint = ApiEndpoints.myFeed;
      final token = getIt<SharedPreferences>().getString(AppConstants.token);

      FormData formData = FormData.fromMap({
        "desc": description, // 👈 match API field name
        "video": await MultipartFile.fromFile(videoPath, filename: "video.mp4"),
        "image": await MultipartFile.fromFile(
          thumbnailPath,
          filename: "thumb.jpg",
        ),
        "category": jsonEncode(categoryIds),
      });

      dynamic responseData = await dioClient.post(endpoint, formData, token);

      log("responseData of sharePost $responseData");
      if (responseData != null && responseData["status"] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("Error in sharePost: $e");
      rethrow;
    }
  }
}

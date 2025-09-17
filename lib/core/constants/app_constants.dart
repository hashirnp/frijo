import 'package:flutter/material.dart';

class AppConstants {
  static const String baseUrl = "https://frijo.noviindus.in/api/";
  static const int connectTimeout = 5000; // ms
  static const int receiveTimeout = 3000;

  static const String token = "token";

  static const white = Colors.white;

  static Color? red = Colors.red;

  String timeAgo(String isoString) {
    try {
      DateTime dateTime = DateTime.parse(isoString).toLocal();
      final Duration diff = DateTime.now().difference(dateTime);

      if (diff.inSeconds < 60) {
        return '${diff.inSeconds}s ago';
      } else if (diff.inMinutes < 60) {
        return '${diff.inMinutes}m ago';
      } else if (diff.inHours < 24) {
        return '${diff.inHours}h ago';
      } else if (diff.inDays < 7) {
        return '${diff.inDays}d ago';
      } else if (diff.inDays < 30) {
        return '${(diff.inDays / 7).floor()} week ago';
      } else if (diff.inDays < 365) {
        return '${(diff.inDays / 30).floor()} month ago';
      } else {
        return '${(diff.inDays / 365).floor()} year ago';
      }
    } catch (e) {
      return isoString;
    }
  }
}

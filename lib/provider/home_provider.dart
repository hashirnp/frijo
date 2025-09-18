import 'package:flutter/cupertino.dart';
import 'package:frijo/controller/feed_controller.dart';
import 'package:frijo/injection.dart';
import 'package:frijo/model/category_response/category_response.dart';
import 'package:frijo/model/video_modal/video_modal.dart';

class HomeProvider with ChangeNotifier {
  final FeedController _controller = getIt<FeedController>();

  bool? _isLoading = false;
  bool? get isLoading => _isLoading;

  CategoryResponse? _categoryResponse;
  CategoryResponse? get categoryResponse => _categoryResponse;

  int? _selectedCategoryIndex = 0;
  int? get getSelectedCategoryIndex => _selectedCategoryIndex;
  void setSelectedCategoryIndex(int index) {
    _selectedCategoryIndex = index;
    notifyListeners();
  }

  List<VideoModal> _videos = [];
  List<VideoModal> get videos => _videos;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void init() async {
    setLoading(true);
    fetchCategories();
    fetchVideos();
    setLoading(false);
  }

  void fetchCategories() async {
    _categoryResponse = await _controller.fetchCategories();
    notifyListeners();
  }

  void fetchVideos() async {
    _videos = await _controller.fetchVideos();
    notifyListeners();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noviindus/controller/feed_controller.dart';
import 'package:noviindus/injection.dart';
import 'package:noviindus/model/category_response/category.dart';
import 'package:noviindus/model/category_response/category_response.dart';
import 'package:noviindus/model/video_modal/video_modal.dart';

class FeedProvider with ChangeNotifier {
  final FeedController _controller = getIt<FeedController>();

  bool? _isLoading = false;
  bool? get isLoading => _isLoading;

  String? _description;
  String? get description => _description;
  void setDescription(String desc) {
    _description = desc;
    notifyListeners();
  }

  XFile? _video;
  XFile? get video => _video;
  void setVideo(XFile? file) {
    _video = file;
    notifyListeners();
  }

  XFile? _thumbnail;
  XFile? get thumbnail => _thumbnail;
  void setThumbnail(XFile? file) {
    _thumbnail = file;
    notifyListeners();
  }

  bool? _postShareStatus;
  bool? get postShareStatus => _postShareStatus;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  CategoryResponse? _categoryResponse;
  CategoryResponse? get categoryResponse => _categoryResponse;

  int? _selectedCategoryIndex = 0;
  int? get getSelectedCategoryIndex => _selectedCategoryIndex;
  void setSelectedCategoryIndex(int index) {
    _selectedCategoryIndex = index;
    notifyListeners();
  }

  final List<Category> _selectedCategories = [];
  List<Category> get selectedCategories => _selectedCategories;
  void toggleCategorySelection(Category categoryId) {
    if (_selectedCategories.contains(categoryId)) {
      _selectedCategories.remove(categoryId);
    } else {
      _selectedCategories.add(categoryId);
    }
    notifyListeners();
  }

  void clearSelectedCategories() {
    _selectedCategories.clear();
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

  void sharePost() async {
    setLoading(true);
    if (_video == null || _thumbnail == null || _selectedCategories.isEmpty) {
      _errorMessage = "Please provide all required fields.";
      _postShareStatus = false;
      setLoading(false);
      notifyListeners();
      return;
    }
    final status = await _controller.sharePost(
      description: _description!,
      videoPath: _video!.path,
      thumbnailPath: _thumbnail!.path,
      categoryIds: _selectedCategories.map((cat) => cat.id!).toList(),
    );
    _postShareStatus = status;
    if (status) {
      _errorMessage = null;
      _selectedCategories.clear();
      _video = null;
      _thumbnail = null;
    } else {
      _errorMessage = "Failed to share post. Please try again.";
    }
    setLoading(false);
    notifyListeners();
  }

  void resetPostStatus() {
    _postShareStatus = null;
    _errorMessage = null;
    notifyListeners();
  }
}

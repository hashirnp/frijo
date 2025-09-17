import 'category.dart';

class CategoryResponse {
  List<Category>? categories;
  bool? status;

  CategoryResponse({this.categories, this.status});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
    'categories': categories?.map((e) => e.toJson()).toList(),
    'status': status,
  };
}

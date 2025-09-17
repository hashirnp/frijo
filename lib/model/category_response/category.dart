class Category {
  int? id;
  String? title;
  String? image;

  Category({this.id, this.title, this.image});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['id'] as int?,
    title: json['title'] as String?,
    image: json['image'] as String?,
  );

  Map<String, dynamic> toJson() => {'id': id, 'title': title, 'image': image};
}

class User {
  int? id;
  String? name;
  dynamic image;

  User({this.id, this.name, this.image});

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as int?,
    name: json['name'] as String?,
    image: json['image'] as dynamic,
  );

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'image': image};
}

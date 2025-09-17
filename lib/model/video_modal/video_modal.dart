import 'user.dart';

class VideoModal {
  int? id;
  String? description;
  String? image;
  String? video;
  List<dynamic>? likes;
  List<dynamic>? dislikes;
  List<dynamic>? bookmarks;
  List<dynamic>? hide;
  DateTime? createdAt;
  bool? follow;
  User? user;

  VideoModal({
    this.id,
    this.description,
    this.image,
    this.video,
    this.likes,
    this.dislikes,
    this.bookmarks,
    this.hide,
    this.createdAt,
    this.follow,
    this.user,
  });

  factory VideoModal.fromJson(Map<String, dynamic> json) => VideoModal(
    id: json['id'] as int?,
    description: json['description'] as String?,
    image: json['image'] as String?,
    video: json['video'] as String?,
    likes: json['likes'] as List<dynamic>?,
    dislikes: json['dislikes'] as List<dynamic>?,
    bookmarks: json['bookmarks'] as List<dynamic>?,
    hide: json['hide'] as List<dynamic>?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    follow: json['follow'] as bool?,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'description': description,
    'image': image,
    'video': video,
    'likes': likes,
    'dislikes': dislikes,
    'bookmarks': bookmarks,
    'hide': hide,
    'created_at': createdAt?.toIso8601String(),
    'follow': follow,
    'user': user?.toJson(),
  };
}

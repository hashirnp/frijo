class User {
  int? id;
  String? uniqueId;
  dynamic name;
  String? phone;
  dynamic image;
  int? coins;
  dynamic credit;
  dynamic debit;

  User({
    this.id,
    this.uniqueId,
    this.name,
    this.phone,
    this.image,
    this.coins,
    this.credit,
    this.debit,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as int?,
    uniqueId: json['unique_id'] as String?,
    name: json['name'] as dynamic,
    phone: json['phone'] as String?,
    image: json['image'] as dynamic,
    coins: json['coins'] as int?,
    credit: json['credit'] as dynamic,
    debit: json['debit'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'unique_id': uniqueId,
    'name': name,
    'phone': phone,
    'image': image,
    'coins': coins,
    'credit': credit,
    'debit': debit,
  };
}

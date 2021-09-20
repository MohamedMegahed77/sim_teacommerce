class User {
  late String token;
  late DateTime tokenExpireTime;
  late String userName;
  late int userId;
  late String name;
  late String imgUrl;

  User({
    required this.token,
    required this.tokenExpireTime,
    required this.userName,
    required this.userId,
    required this.name,
    required this.imgUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        token: json['token'],
        tokenExpireTime: DateTime.now(),
        userName: json['userName'],
        userId: json['userId'],
        name: json['name'],
        imgUrl: json['imgUrl']);
  }
}

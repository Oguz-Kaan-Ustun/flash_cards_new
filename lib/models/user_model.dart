

class UserModel {
  String nickName;
  String userId;
  String email;
  String role;


  UserModel({
    required this.nickName,
    required this.userId,
    required this.email,
    required this.role,
  });

  UserModel.fromJson(Map<String, Object?> json)
      : this(
    nickName: json['name']! as String,
    userId: json['contents']! as String,
    email: json['name']! as String,
    role: json['role']! as String
  );

  UserModel copyWith({
    String? nickName,
    String? userId,
    String? email,
    String? role
  }) {
    return UserModel(
        nickName: nickName ?? this.nickName,
        userId: userId ?? this.userId,
        email: email ?? this.email,
        role: role ?? this.role
    );
  }

  Map<String, Object?> toJson() {
    return {
      'nickName': nickName,
      'userId': userId,
      'email': email,
      'role': role
    };
  }
}
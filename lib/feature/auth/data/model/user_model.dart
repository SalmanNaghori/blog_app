import 'package:blog_app/core/common/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.email,
    required super.name,
    required super.id,
  });

  factory UserModel.from(Map<String, dynamic> map) {
    return UserModel(
      email: map["email"] ?? '',
      name: map["name"] ?? '',
      id: map["sub"] ?? '',
    );
  }
  UserModel copyWith({
    String? email,
    String? name,
    String? id,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  @override
  String toString() {
    return 'UserModel(email: $email, name: $name, id: $id)';
  }
}

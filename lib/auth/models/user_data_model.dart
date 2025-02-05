import 'package:firebase_auth/firebase_auth.dart';

class UserDataModel {
  String? id;
  String? name;
  String? email;
  String? password;

  UserDataModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}

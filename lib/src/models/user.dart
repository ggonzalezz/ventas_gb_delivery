import 'dart:convert';

import 'package:ventas_gb_delivery/src/models/rol.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String id ;
  String name;
  String lastname;
  String email;
  String phone;
  String password;
  String session_token;
  String image;
  List<Rol> roles =[];
  User({
     this.id,
     this.name,
     this.lastname,
     this.email,
     this.phone,
     this.password,
     this.session_token,
     this.image,
     this.roles
  });



  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] is int ? json['id'].toString() : json["id"],
    name: json["name"],
    lastname: json["lastname"],
    email: json["email"],
    phone: json["phone"],
    password: json["password"],
      session_token: json["session_token"],
    image: json["image"],
    roles: json["roles"] == null ? [] : List<Rol>.from(json['roles'].map((model) => Rol.fromJson(model))) ?? [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "lastname": lastname,
    "email": email,
    "phone": phone,
    "password": password,
    "session_token": session_token,
    "image": image,
    "roles": roles,
  };
}

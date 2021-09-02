import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  String id;
  String fName;
  String lName;
  String email;
  String city;
  String country;
  String imageUrl;
  UserModel({
    @required this.id,
    @required this.fName,
    @required this.lName,
    @required this.email,
    @required this.city,
    @required this.country,
    @required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      // 'email': email,
      'fName': fName,
      'lName': lName,
      'city': city,
      'country': country,
      'imageUrl': imageUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      fName: map['fName'],
      lName: map['lName'],
      email: map['email'],
      city: map['city'],
      country: map['country'],
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, fName: $fName, lName: $lName, email: $email, city: $city, country: $country, imageUrl: $imageUrl)';
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';

class CountryModel {
  String id;
  String name;
  List<dynamic> cities;

  CountryModel({
    @required this.id,
    @required this.name,
    @required this.cities,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cities': cities,
    };
  }

  factory CountryModel.fromMap(Map<String, dynamic> map) {
    return CountryModel(
      id: map['id'],
      name: map['name'],
      cities: List<dynamic>.from(map['cities']),
    );
  }

  String toJson() => json.encode(toMap());
  factory CountryModel.fromJson(String source) =>
      CountryModel.fromMap(json.decode(source));

  @override
  String toString() => 'CountryModel(id: $id, name: $name, cities: $cities)';
}

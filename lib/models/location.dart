import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class OfficeLocation {
  final String title;
  final String? description;
  final double latitude;
  final double longitude;

  OfficeLocation({
    required this.title,
    this.description,
    required this.latitude,
    required this.longitude,
  });

  OfficeLocation copyWith({
    String? title,
    String? description,
    double? latitude,
    double? longitude,
  }) {
    return OfficeLocation(
      title: title ?? this.title,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory OfficeLocation.fromMap(Map<String, dynamic> map) {
    return OfficeLocation(
      title: map['title'],
      description: map['description'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OfficeLocation.fromJson(String source) =>
      OfficeLocation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OfficeLocation(title: $title, description: $description, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OfficeLocation &&
        other.title == title &&
        other.description == description &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}

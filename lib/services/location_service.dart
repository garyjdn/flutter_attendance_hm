import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/location.dart';

abstract class LocationServiceInterface {
  Future<void> addLocation(OfficeLocation location);
}

class LocationService implements LocationServiceInterface {
  final FirebaseFirestore firestore;

  LocationService({required this.firestore});

  CollectionReference<Map<String, dynamic>> get _locations =>
      firestore.collection('locations');

  Future<void> getAllLocation() async {}

  Future<void> addLocation(OfficeLocation location) async {
    return _locations
        .add(location.toMap())
        .then((value) => print("Location Added"))
        .catchError((error) => print("Failed to add location: $error"));
    ;
  }
}

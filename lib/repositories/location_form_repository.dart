import '../models/location.dart';
import '../services/location_service.dart';

abstract class LocationFormRepositoryInterface {
  Future<void> addLocation({
    required String title,
    String? description,
    required double latitude,
    required double longitude,
  });
}

class LocationFormRepository implements LocationFormRepositoryInterface {
  final LocationServiceInterface locationService;

  LocationFormRepository({required this.locationService});

  Future<void> addLocation({
    required String title,
    String? description,
    required double latitude,
    required double longitude,
  }) async {
    final location = OfficeLocation(
      title: title,
      description: description,
      latitude: latitude,
      longitude: longitude,
    );
    await locationService.addLocation(location);
  }
}

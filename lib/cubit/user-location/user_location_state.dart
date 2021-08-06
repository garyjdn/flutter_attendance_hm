part of 'user_location_cubit.dart';

@immutable
abstract class UserLocationState {}

class UserLocationNotAvailable extends UserLocationState {}

class UserLocationAvailable extends UserLocationState {
  final LocationData locationData;

  UserLocationAvailable({required this.locationData});
}

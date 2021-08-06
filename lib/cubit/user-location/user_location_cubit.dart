import 'package:bloc/bloc.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';

part 'user_location_state.dart';

class UserLocationCubit extends Cubit<UserLocationState> {
  UserLocationCubit() : super(UserLocationNotAvailable());

  void getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        emit(UserLocationNotAvailable());
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        emit(UserLocationNotAvailable());
      }
    }

    emit(UserLocationAvailable(locationData: await location.getLocation()));

    // Emit Realtime location
    // location.onLocationChanged.listen((LocationData currentLocation) {
    //   emit(UserLocationAvailable(locationData: currentLocation));
    // });
  }
}

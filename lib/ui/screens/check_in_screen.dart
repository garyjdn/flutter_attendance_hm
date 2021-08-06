import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../cubit/firestore/firestore_cubit.dart';
import '../../cubit/user-location/user_location_cubit.dart';
import '../../models/location.dart';
import '../shared/curve_background.dart';
import '../shared/loading_placeholder.dart';

class CheckInScreen extends StatelessWidget {
  const CheckInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserLocationCubit>(
          create: (context) => UserLocationCubit()..getLocation(),
        ),
      ],
      child: CheckInView(),
    );
  }
}

class CheckInView extends StatefulWidget {
  const CheckInView({Key? key}) : super(key: key);

  @override
  _CheckInViewState createState() => _CheckInViewState();
}

class _CheckInViewState extends State<CheckInView> {
  bool _isLoading = false;
  List<OfficeLocation> locations = [];
  late FirebaseFirestore instance;

  void _checkIn(
    double userLatitude,
    double userLongitude,
  ) {
    setState(() => _isLoading = true);
    final Distance distance = new Distance();
    OfficeLocation? locationData;

    for (int i = 0; i < locations.length; i++) {
      double meter = distance(LatLng(userLatitude, userLongitude),
          LatLng(locations[i].latitude, locations[i].longitude));
      if (meter < 50) {
        locationData = locations[i];
        break;
      }
    }

    if (locationData != null) {
      instance.collection('attendances').add({
        'title': locationData.title,
        'description': locationData.description,
        'timestamp': Timestamp.now(),
      });
      final snackBar = SnackBar(
        content: Text(
          'Check In Success',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).pop();
    } else {
      final errorSnackBar = SnackBar(
        content: Text(
          'Location Not Found: Out of Range',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
    }

    setState(() => _isLoading = false);
  }

  void _fetchLocations() async {
    final querySnapshot = await instance.collection('locations').get();
    querySnapshot.docs.forEach((ds) {
      locations.add(OfficeLocation.fromMap(ds.data()));
    });
  }

  @override
  void initState() {
    super.initState();
    instance =
        BlocProvider.of<FirestoreCubit>(context, listen: false).state.instance;
    _fetchLocations();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    LatLng markerPosition = LatLng(-7.442518067825459, 112.70282384811448);
    return Scaffold(
      body: Stack(
        children: [
          CurveBackground(),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, 20 + MediaQuery.of(context).padding.top, 20, 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: size.height * 0.7,
                      child: BlocBuilder<UserLocationCubit, UserLocationState>(
                        builder: (ctx, state) {
                          if (state is UserLocationNotAvailable) {
                            return LoadingPlaceholder();
                          } else if (state is UserLocationAvailable) {
                            double lat = state.locationData.latitude ??
                                markerPosition.latitude;
                            double lng = state.locationData.longitude ??
                                markerPosition.longitude;

                            Marker userMarker = Marker(
                              width: 35.0,
                              height: 35.0,
                              point: LatLng(
                                lat,
                                lng,
                              ),
                              builder: (ctx) => Container(
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 35,
                                ),
                              ),
                            );

                            List<Marker> markers = [userMarker];

                            return FlutterMap(
                              options: MapOptions(
                                center: LatLng(
                                  lat,
                                  lng,
                                ),
                                zoom: 18.0,
                              ),
                              layers: [
                                TileLayerOptions(
                                    urlTemplate:
                                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                    subdomains: ['a', 'b', 'c']),
                                MarkerLayerOptions(
                                  markers: markers,
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(20),
                      child: BlocBuilder<UserLocationCubit, UserLocationState>(
                        builder: (context, state) {
                          if (state is UserLocationNotAvailable) {
                            return Container(
                              width: double.infinity,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                    strokeWidth: 2.5,
                                  ),
                                ),
                              ),
                            );
                          } else if (state is UserLocationAvailable) {
                            double lat = state.locationData.latitude ??
                                markerPosition.latitude;
                            double lng = state.locationData.longitude ??
                                markerPosition.longitude;

                            return GestureDetector(
                              onTap: () => _checkIn(lat, lng),
                              child: Container(
                                width: double.infinity,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: _isLoading
                                      ? Container(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                            strokeWidth: 2.5,
                                          ),
                                        )
                                      : Text(
                                          "Check In",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              ?.copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

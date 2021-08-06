import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../cubit/firestore/firestore_cubit.dart';
import '../../cubit/location-form/location_form_cubit.dart';
import '../../cubit/user-location/user_location_cubit.dart';
import '../../others/app_theme.dart';
import '../../repositories/location_form_repository.dart';
import '../../services/location_service.dart';
import '../shared/curve_background.dart';
import '../shared/loading_placeholder.dart';

class MasterDataScreen extends StatelessWidget {
  const MasterDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _fsInstance = context.read<FirestoreCubit>().state.instance;
    final _locationService = LocationService(firestore: _fsInstance);
    final _locationFormRepository =
        LocationFormRepository(locationService: _locationService);
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserLocationCubit>(
          create: (context) => UserLocationCubit()..getLocation(),
        ),
        BlocProvider<LocationFormCubit>(
          create: (context) => LocationFormCubit(
              locationFormRepository: _locationFormRepository),
        ),
      ],
      child: MasterDataView(),
    );
  }
}

class MasterDataView extends StatefulWidget {
  const MasterDataView({Key? key}) : super(key: key);

  @override
  _MasterDataViewState createState() => _MasterDataViewState();
}

class _MasterDataViewState extends State<MasterDataView> {
  final _formKey = GlobalKey<FormState>();
  late MapController mapController;
  bool controllerReady = false;
  bool buildFinished = false;
  LatLng markerPosition = LatLng(-7.442518067825459, 112.70282384811448);

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _latController = TextEditingController();
  TextEditingController _lngController = TextEditingController();

  void initLatLngForm(double? latitude, double? longitude) {
    if (_latController.text.isEmpty && _lngController.text.isEmpty) {
      updateLatLngForm(latitude, longitude);
    }
  }

  void updateLatLngForm(double? latitude, double? longitude) {
    setState(() {
      _latController.text = latitude?.toString() ?? '';
      _lngController.text = longitude?.toString() ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final locationFormCubit =
        BlocProvider.of<LocationFormCubit>(context, listen: false);
    return KeyboardDismissOnTap(
      child: Scaffold(
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
                        height: size.height * 0.4,
                        child:
                            BlocBuilder<UserLocationCubit, UserLocationState>(
                          builder: (ctx, state) {
                            if (state is UserLocationNotAvailable) {
                              return LoadingPlaceholder();
                            } else if (state is UserLocationAvailable) {
                              double lat = state.locationData.latitude ??
                                  markerPosition.latitude;
                              double lng = state.locationData.longitude ??
                                  markerPosition.longitude;

                              return StatefulMap(
                                latitude: lat,
                                longitude: lng,
                                initLatLngForm: initLatLngForm,
                                updateLatLngForm: updateLatLngForm,
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Add new Location",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              SizedBox(height: 20),
                              Text("Title"),
                              SizedBox(height: 6),
                              TextFormField(
                                controller: _titleController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  filled: true,
                                  fillColor: AppTheme.surfaceColor,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                        color: AppTheme.surfaceColor),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                        color: AppTheme.surfaceColor),
                                  ),
                                ),
                                validator: (String? val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Title required';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 12),
                              Text("Description"),
                              SizedBox(height: 6),
                              TextFormField(
                                controller: _descController,
                                minLines: 2,
                                maxLines: 4,
                                decoration: InputDecoration(
                                  isDense: true,
                                  filled: true,
                                  fillColor: AppTheme.surfaceColor,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                        color: AppTheme.surfaceColor),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                        color: AppTheme.surfaceColor),
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              Row(
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("Latitude"),
                                        SizedBox(height: 6),
                                        TextFormField(
                                          controller: _latController,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            filled: true,
                                            fillColor: AppTheme.surfaceColor,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              borderSide: BorderSide(
                                                  color: AppTheme.surfaceColor),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              borderSide: BorderSide(
                                                  color: AppTheme.surfaceColor),
                                            ),
                                          ),
                                          validator: (String? val) {
                                            if (val == null || val.isEmpty) {
                                              return 'Latitude required';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("Longitude"),
                                        SizedBox(height: 6),
                                        TextFormField(
                                          controller: _lngController,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            filled: true,
                                            fillColor: AppTheme.surfaceColor,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              borderSide: BorderSide(
                                                  color: AppTheme.surfaceColor),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              borderSide: BorderSide(
                                                  color: AppTheme.surfaceColor),
                                            ),
                                          ),
                                          validator: (String? val) {
                                            if (val == null || val.isEmpty) {
                                              return 'Longitude required';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 24),
                              BlocConsumer<LocationFormCubit,
                                  LocationFormState>(
                                listener: (context, state) {
                                  if (state is LocationFormSubmitSuccess) {
                                    // empty all text field
                                    _titleController.clear();
                                    _descController.clear();
                                    final snackBar = SnackBar(
                                      content: Text(
                                        'New Location has been added',
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                },
                                builder: (context, state) {
                                  if (state is LocationFormSubmitInProgress) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      padding: EdgeInsets.all(10),
                                      width: double.infinity,
                                      child: Center(
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                            strokeWidth: 2.5,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        locationFormCubit.addLocation(
                                          title: _titleController.text,
                                          description: _descController.text,
                                          latitude:
                                              double.parse(_latController.text),
                                          longitude:
                                              double.parse(_lngController.text),
                                        );
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      padding: EdgeInsets.all(10),
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add, color: Colors.white),
                                          SizedBox(width: 4),
                                          Text(
                                            "Add",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                ?.copyWith(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class StatefulMap extends StatefulWidget {
  final double latitude;
  final double longitude;
  final Function(double?, double?) initLatLngForm;
  final Function(double?, double?) updateLatLngForm;

  const StatefulMap({
    Key? key,
    required this.latitude,
    required this.longitude,
    required this.initLatLngForm,
    required this.updateLatLngForm,
  }) : super(key: key);

  @override
  _StatefulMapState createState() => _StatefulMapState();
}

class _StatefulMapState extends State<StatefulMap> {
  late double latitude;
  late double longitude;

  late Marker marker;
  late List<Marker> markers;

  @override
  void initState() {
    super.initState();
    latitude = widget.latitude;
    longitude = widget.longitude;

    marker = Marker(
      width: 25.0,
      height: 25.0,
      point: LatLng(
        latitude,
        longitude,
      ),
      builder: (ctx) => Container(
        child: Icon(
          Icons.push_pin,
          color: Colors.red,
          size: 25,
        ),
      ),
    );
    markers = [marker];

    WidgetsBinding.instance!.addPostFrameCallback(
        (_) => widget.initLatLngForm(latitude, longitude));
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(
          latitude,
          longitude,
        ),
        zoom: 18.0,
        onTap: (LatLng? latlng) {
          Marker newMarker = Marker(
            width: 25.0,
            height: 25.0,
            point: latlng ??
                LatLng(
                  latitude,
                  longitude,
                ),
            builder: (ctx) => Container(
              child: Icon(
                Icons.push_pin,
                color: Colors.red,
                size: 25,
              ),
            ),
          );
          setState(() {
            markers = [newMarker];
          });
          widget.updateLatLngForm(latlng?.latitude, latlng?.longitude);
        },
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        MarkerLayerOptions(
          markers: markers,
        ),
      ],
    );
  }
}

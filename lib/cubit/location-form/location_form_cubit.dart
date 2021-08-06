import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repositories/location_form_repository.dart';

part 'location_form_state.dart';

class LocationFormCubit extends Cubit<LocationFormState> {
  final LocationFormRepositoryInterface locationFormRepository;

  LocationFormCubit({
    required this.locationFormRepository,
  }) : super(LocationFormInitial());

  void addLocation({
    required String title,
    String? description,
    required double latitude,
    required double longitude,
  }) async {
    emit(LocationFormSubmitInProgress());
    await locationFormRepository.addLocation(
      title: title,
      description: description,
      latitude: latitude,
      longitude: longitude,
    );
    emit(LocationFormSubmitSuccess());
  }
}

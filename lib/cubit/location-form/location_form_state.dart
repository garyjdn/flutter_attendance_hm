part of 'location_form_cubit.dart';

@immutable
abstract class LocationFormState {}

class LocationFormInitial extends LocationFormState {}

class LocationFormSubmitInProgress extends LocationFormState {}

class LocationFormSubmitSuccess extends LocationFormState {}

class LocationFormSubmitFailure extends LocationFormState {}

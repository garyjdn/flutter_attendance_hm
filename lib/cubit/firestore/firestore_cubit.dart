import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'firestore_state.dart';

class FirestoreCubit extends Cubit<FirestoreState> {
  FirestoreCubit(instance) : super(FirestoreInitial(instance));
}

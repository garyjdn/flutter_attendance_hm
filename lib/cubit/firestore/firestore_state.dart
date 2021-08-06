part of 'firestore_cubit.dart';

@immutable
abstract class FirestoreState {
  final FirebaseFirestore instance;
  FirestoreState(this.instance);
}

class FirestoreInitial extends FirestoreState {
  FirestoreInitial(FirebaseFirestore instance) : super(instance);
}

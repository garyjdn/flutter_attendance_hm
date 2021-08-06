import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/firestore/firestore_cubit.dart';
import 'others/app_theme.dart';
import 'ui/screens/home_screen.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final instance = FirebaseFirestore.instance;
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<FirestoreCubit>(
          create: (context) => FirestoreCubit(instance),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HashMicro Attendance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: AppTheme.backgroundColor,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black54,
              displayColor: Colors.black54,
            ),
        iconTheme: Theme.of(context).iconTheme.copyWith(
              color: Colors.black54,
            ),
      ),
      home: HomeScreen(),
    );
  }
}

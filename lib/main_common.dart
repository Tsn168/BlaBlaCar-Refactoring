// filepath: lib/app/main_common.dart
import '../data/repositories/location/location_repository.dart';
import '../data/repositories/ride_preference/ride_preference_repository.dart';
import '../data/repositories/ride/ride_repository.dart';
import '../ui/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void mainCommon({
  required LocationsRepository locationsRepository,
  required RidesRepository ridesRepository,
  required RidePrefsRepository ridePrefsRepository,
}) {
  runApp(
    MultiProvider(
      providers: [
        Provider<LocationsRepository>.value(value: locationsRepository),
        Provider<RidesRepository>.value(value: ridesRepository),
        Provider<RidePrefsRepository>.value(value: ridePrefsRepository),
      ],
      child: const BlaBlaApp(),
    ),
  );
}

class BlaBlaApp extends StatelessWidget {
  const BlaBlaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'BlaBlaApp', home: HomeScreen());
  }
}

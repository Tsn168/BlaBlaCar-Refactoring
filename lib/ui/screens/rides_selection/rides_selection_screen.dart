import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/ride/ride_repository.dart';
import '../../../model/ride/ride.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../services/ride_prefs_service.dart';
import '../../../utils/animations_util.dart' show AnimationUtils;
import '../../theme/theme.dart';
import 'widgets/ride_preference_modal.dart';
import 'widgets/rides_selection_header.dart';
import 'widgets/rides_selection_tile.dart';

///
///  The Ride Selection screen allows user to select a ride, once ride preferences have been defined.
///  The screen also allow user to:
///   -  re-define the ride preferences
///   -  activate some filters.
///
class RidesSelectionScreen extends StatefulWidget {
  const RidesSelectionScreen({super.key});

  @override
  State<RidesSelectionScreen> createState() => _RidesSelectionScreenState();
}

class _RidesSelectionScreenState extends State<RidesSelectionScreen> {
  late Future<List<Ride>> _matchingRidesFuture;

  @override
  void initState() {
    super.initState();
    // Initially, fetch rides using the preference from the static service.
    _matchingRidesFuture = context.read<RidesRepository>().getRidesFor(
      RidePrefsService.selectedPreference!,
    );
  }

  void onBackTap() {
    Navigator.pop(context);
  }

  void onFilterPressed() {
    // TODO
  }

  void onRideSelected(Ride ride) {
    // Later
  }

  // This getter is still needed for the header and for updating preferences.
  RidePreference get selectedRidePreference =>
      RidePrefsService.selectedPreference!;

  void onPreferencePressed() async {
    // 1 - Navigate to the rides preference picker
    RidePreference? newPreference = await Navigator.of(context)
        .push<RidePreference>(
          AnimationUtils.createRightToLeftRoute(
            RidePreferenceModal(initialPreference: selectedRidePreference),
          ),
        );

    if (newPreference != null) {
      // 2 - Ask the service to update the current preference
      RidePrefsService.selectPreference(newPreference);

      // 3 - Update the widget state by re-fetching the rides with the new preference
      setState(() {
        _matchingRidesFuture = context.read<RidesRepository>().getRidesFor(
          newPreference,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          children: [
            RideSelectionHeader(
              ridePreference: selectedRidePreference,
              onBackPressed: onBackTap,
              onFilterPressed: onFilterPressed,
              onPreferencePressed: onPreferencePressed,
            ),
            const SizedBox(height: BlaSpacings.m),
            Expanded(
              child: FutureBuilder<List<Ride>>(
                future: _matchingRidesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No rides found for this search.'),
                    );
                  }

                  final matchingRides = snapshot.data!;
                  return ListView.builder(
                    itemCount: matchingRides.length,
                    itemBuilder: (ctx, index) => RideSelectionTile(
                      ride: matchingRides[index],
                      onPressed: () => onRideSelected(matchingRides[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

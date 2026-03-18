import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:blabla/ui/state/ride_preference_state.dart';
import 'package:flutter/foundation.dart';

class HomeViewModel extends ChangeNotifier {
  final RidePreferenceState _ridePreferenceState;
  late final VoidCallback _listener;

  List<RidePreference> get preferenceHistory => _ridePreferenceState.history;
  bool get isLoading => _ridePreferenceState.isLoading;

  HomeViewModel(this._ridePreferenceState) {
    _listener = () => notifyListeners();
    _ridePreferenceState.addListener(_listener);
  }

  void onRidePreferenceSelected(RidePreference preference) {
    _ridePreferenceState.selectPreference(preference);
  }

  @override
  void dispose() {
    _ridePreferenceState.removeListener(
      _listener,
    ); // Stop listening to the global state
    super.dispose();
  }
}

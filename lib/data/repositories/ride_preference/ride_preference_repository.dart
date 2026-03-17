import '../../../model/ride_pref/ride_pref.dart';

abstract class RidePrefsRepository {
  Future<void> setSelectedPreference(RidePreference pref);
  Future<RidePreference?> getSelectedPreference();
  Future<List<RidePreference>> getPreferenceHistory();
}

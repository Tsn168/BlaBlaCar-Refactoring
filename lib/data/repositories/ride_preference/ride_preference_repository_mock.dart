import '../../../model/ride_pref/ride_pref.dart';
import 'ride_preference_repository.dart';

class RidePrefsRepositoryMock implements RidePrefsRepository {
  final List<RidePreference> _history = [];
  RidePreference? _selectedPreference;

  @override
  Future<List<RidePreference>> getPreferenceHistory() async {
    return List.unmodifiable(_history);
  }

  @override
  Future<RidePreference?> getSelectedPreference() async {
    return _selectedPreference;
  }

  @override
  Future<void> setSelectedPreference(RidePreference pref) async {
    _selectedPreference = pref;
    // Add to history if it's a new, unique preference
    if (!_history.any(
      (p) =>
          p.departure.name == pref.departure.name &&
          p.arrival.name == pref.arrival.name,
    )) {
      _history.insert(0, pref);
    }
  }
}

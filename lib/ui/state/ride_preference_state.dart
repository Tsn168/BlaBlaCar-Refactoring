import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:flutter/foundation.dart';
import '../../data/repositories/ride_preference/ride_preference_repository.dart';

class RidePreferenceState extends ChangeNotifier {
  final RidePrefsRepository _repository;

  RidePreferenceState(this._repository) {
    // Load the history as soon as the state is created
    _loadHistory();
  }

  // Private fields to hold the state
  RidePreference? _selectedPreference;
  List<RidePreference> _history = [];
  bool _isLoading = true;

  // Public getters so the UI can read the state
  RidePreference? get selectedPreference => _selectedPreference;
  List<RidePreference> get history => _history;
  bool get isLoading => _isLoading;

  Future<void> _loadHistory() async {
    _history = await _repository.getPreferenceHistory();
    _isLoading = false;
    notifyListeners(); // Notify UI that loading is complete
  }

  /// This is the main method the UI will call to update the state.
  Future<void> selectPreference(RidePreference newPreference) async {
    // Do nothing if the preference is the same
    if (newPreference == _selectedPreference) {
      return;
    }

    // 1. Update the current preference
    _selectedPreference = newPreference;

    // 2. Ask the repository to save/update the preference
    await _repository.setSelectedPreference(newPreference);

    // 3. Reload the history from the repository to ensure it's up-to-date
    _history = await _repository.getPreferenceHistory();

    // 4. Notify all listening widgets that the state has changed!
    notifyListeners();
  }
}

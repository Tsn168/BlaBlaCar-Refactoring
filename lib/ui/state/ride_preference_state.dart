import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:flutter/foundation.dart';
import '../../data/repositories/ride_preference/ride_preference_repository.dart';

class RidePreferenceState extends ChangeNotifier {
  final RidePrefsRepository _repository;

  RidePreferenceState(this._repository) {
    _loadHistory();
  }

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

  Future<void> selectPreference(RidePreference newPreference) async {
    if (newPreference == _selectedPreference) {
      return;
    }

    _selectedPreference = newPreference;

    await _repository.setSelectedPreference(newPreference);

    _history = await _repository.getPreferenceHistory();

    notifyListeners();
  }
}

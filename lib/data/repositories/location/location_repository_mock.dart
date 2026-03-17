import '../../dummy_data.dart';
import '../../../model/ride/locations.dart';
import 'location_repository.dart';

class LocationsRepositoryMock implements LocationsRepository {
  @override
  Future<List<Location>> getAvailableLocations() async {
    // For now, just return the hardcoded list.
    return fakeLocations;
  }
}

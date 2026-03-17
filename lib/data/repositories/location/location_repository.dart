import '../../../model/ride/locations.dart';

abstract class LocationsRepository {
  Future<List<Location>> getAvailableLocations();
}

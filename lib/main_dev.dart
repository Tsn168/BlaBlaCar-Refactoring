// filepath: lib/app/main_dev.dart
import 'data/repositories/location/location_repository_mock.dart';
import 'data/repositories/ride_preference/ride_preference_repository_mock.dart';
import 'data/repositories/ride/ride_repository_mock.dart';

import 'main_common.dart';

void main() {
  mainCommon(
    locationsRepository: LocationsRepositoryMock(),
    ridesRepository: RidesRepositoryMock(),
    ridePrefsRepository: RidePrefsRepositoryMock(),
  );
}

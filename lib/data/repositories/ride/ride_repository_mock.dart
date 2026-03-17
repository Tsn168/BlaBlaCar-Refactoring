import '../../dummy_data.dart';
import '../../../model/ride/ride.dart';
import '../../../model/ride_pref/ride_pref.dart';
import 'ride_repository.dart';

class RidesRepositoryMock implements RidesRepository {
  @override
  Future<List<Ride>> getRidesFor(RidePreference preference) async {
    // This replaces the logic from the old RidesService.
    return fakeRides.where((ride) {
      return ride.departureLocation.name == preference.departure.name &&
          ride.arrivalLocation.name == preference.arrival.name &&
          ride.availableSeats >= preference.requestedSeats;
    }).toList();
  }
}

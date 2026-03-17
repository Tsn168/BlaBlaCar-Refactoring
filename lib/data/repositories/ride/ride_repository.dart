import '../../../model/ride/ride.dart';
import '../../../model/ride_pref/ride_pref.dart';

abstract class RidesRepository {
  Future<List<Ride>> getRidesFor(RidePreference preference);
}

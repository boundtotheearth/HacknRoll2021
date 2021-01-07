import 'package:geolocator/geolocator.dart';
import 'package:hacknroll2021/Carpark.dart';
import 'package:hacknroll2021/DataSource.dart';
import 'package:latlong/latlong.dart';

class Location {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<List<Carpark>> returnNearestCarparkList() async {
    double distanceQuota = 500.0;
    DataSource dataSource = new DataSource();
    List<Carpark> carparkList = await dataSource.fetchData();
    List<Carpark> nearestCarparkList = new List<Carpark>();
    Position position = await _determinePosition();
    var currentPosition = new LatLng(position.latitude, position.longitude);
    //var currentPosition = new LatLng(1.3753456822780044, 103.95699270293869);
    var distance = new Distance();
    for (int i = 0; i < carparkList.length; i++) {
      Carpark carpark = carparkList.elementAt(i);
      var carparkPosition =
          new LatLng(carpark.location.latitude, carpark.location.longitude);
      if (distance.as(LengthUnit.Meter, currentPosition, carparkPosition) <
          distanceQuota) {
        nearestCarparkList.add(carpark);
      }
    }
    return nearestCarparkList;
  }

  Future<LatLng> returnCurrentPosition() async {
    Position position = await _determinePosition();
    LatLng currentPosition = new LatLng(position.latitude, position.longitude);
    return currentPosition;
  }
}

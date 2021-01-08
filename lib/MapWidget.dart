import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hacknroll2021/Carpark.dart';
import 'package:hacknroll2021/Location.dart';
import './Place.dart';
import "package:google_maps_webservice/places.dart";

class MapWidget extends StatefulWidget {
  Function(Carpark) selectCallback;
  MapWidget({this.selectCallback, Key key}) : super(key: key);

  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  Future<List<Carpark>> _carparkList;
  GoogleMapController _mapController;

  String _mapStyle;
  BitmapDescriptor _availableIcon;
  BitmapDescriptor _notAvailableIcon;
  LocationService _locationHandler;

  Set<Marker> markers;

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });

//    DataSource ds = new DataSource();
//    _carparkList = ds.fetchData();
    _locationHandler = new LocationService();
    _carparkList = _locationHandler.returnNearestCarparkListFromCurrent();

    getBytesFromAsset("assets/images/GreenMarker.png", 100).then((bitmap) {
      _availableIcon = BitmapDescriptor.fromBytes(bitmap);
    });

    getBytesFromAsset("assets/images/RedMarker.png", 100).then((bitmap) {
      _notAvailableIcon = BitmapDescriptor.fromBytes(bitmap);
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  void moveToSearchLocation(Place place) async {
    final places =
    new GoogleMapsPlaces(apiKey: FlutterConfig.get('MAPS_API_KEY'));
    PlacesDetailsResponse response =
    await places.getDetailsByPlaceId(place.placeId);
    Location loc = response.result.geometry.location;
    CameraPosition(target: LatLng(loc.lat, loc.lng));
    CameraUpdate cameraUpdate = CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(loc.lat, loc.lng), zoom: 17.0));
    print("Moving");
    _mapController.moveCamera(cameraUpdate);
    setState(() {
      _carparkList = _locationHandler.returnNearestCarparkList(loc.lat, loc.lng);
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _mapController.setMapStyle(_mapStyle);
  }

  Set<Marker> generateMarkers(List<Carpark> carparkList) {
    return carparkList.map((carpark) {
      return Marker(
        markerId: MarkerId(carpark.carparkId),
        position: carpark.location,
        // infoWindow: InfoWindow(
        //     title: carpark.development,
        //     snippet: carpark.availableLots.toString() + " Lots Available"),
        icon: carpark.availableLots > 10 ? _availableIcon : _notAvailableIcon,
        onTap: () {
          widget.selectCallback(carpark);
        },
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Carpark>>(
        future: _carparkList,
        builder: (BuildContext context, AsyncSnapshot<List<Carpark>> snapshot) {
          if (snapshot.hasData) {
            List<Carpark> data = snapshot.data;
            Set<Marker> markers = generateMarkers(data);
            LatLng currentPosition = LatLng(
                _locationHandler.currentPosition.latitude,
                _locationHandler.currentPosition.longitude);
            return GoogleMap(
              onMapCreated: _onMapCreated,
              tiltGesturesEnabled: false,
              initialCameraPosition: CameraPosition(
                target: currentPosition,
                zoom: 17.0,
              ),
              markers: markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

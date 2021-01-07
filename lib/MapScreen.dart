import 'package:flutter/material.dart';
import 'package:hacknroll2021/CarparkList.dart';
import 'package:hacknroll2021/MapWidget.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapWidget(),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hacknroll2021/MapWidget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import './CarparkDetails.dart';

/*
    to programatically open/close bottom sheet, use:
      _pc.open()
      _pc.close()
      _pc.show()
      _pc.hide()
  */

class MapScreen extends StatefulWidget {
  MapScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  PanelController _pc = PanelController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        body: MapWidget(),
        controller: _pc,
        isDraggable: false,
        panelBuilder: (sc) => _panel(sc),
        minHeight: 225,
      ),
    );
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: CarParkDetails(sc, null),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hacknroll2021/Carpark.dart';
import 'package:hacknroll2021/HDBCarparkDetails.dart';
import 'package:hacknroll2021/MallCarparkDetails.dart';
import 'package:hacknroll2021/HDBCarpark.dart';
import 'package:hacknroll2021/MallCarpark.dart';
import 'package:hacknroll2021/MapWidget.dart';
import 'package:hacknroll2021/Place.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import './CarparkDetails.dart';
import './SearchBar.dart';
import 'ModelLoader.dart';

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
  PanelController _pc;
  Carpark _selectedCarpark;
  GlobalKey<MapWidgetState> mapWidgetKey = GlobalKey();
  ModelLoader _modelLoader;
  void selectCarpark(Carpark carpark) {
    setState(() {
      _selectedCarpark = carpark;
      _pc.show();
    });
  }

  @override
  void initState() {
    super.initState();
    _pc = new PanelController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _pc.hide());
    _modelLoader = ModelLoader();
    _loadModel();
  }

  void _loadModel() async {
    await _modelLoader.init();
  }

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );

    Function updateSearchLocationCallBack = (Place place) {
      mapWidgetKey.currentState.moveToSearchLocation(place);
    };

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SlidingUpPanel(
            body: MapWidget(
              selectCallback: selectCarpark,
              key: mapWidgetKey,
            ),
            controller: _pc,
            isDraggable: false,
            panelBuilder: (sc) => _panel(sc),
            minHeight: 225,
            borderRadius: radius,
          ),
          SearchBarWrapper(
            updateSearchLocationCallBack: updateSearchLocationCallBack,
          ),
        ],
      ),
    );
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: buildPanel(sc),
    );
  }

  Widget buildPanel(ScrollController sc) {
    if (_selectedCarpark is HDBCarpark) {
      return HDBCarParkDetails(sc, _selectedCarpark.withPrice(), _modelLoader);
    } else if (_selectedCarpark is MallCarpark) {
      return MallCarParkDetails(sc, _selectedCarpark.withPrice(), _modelLoader);
    } else {
      return CarParkDetails(sc, _selectedCarpark, _modelLoader);
    }
  }
}

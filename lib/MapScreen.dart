import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hacknroll2021/MapWidget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import './Carpark.dart';

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

class CarParkDetails extends StatelessWidget {
  // const CarParkDetails({
  //   Key key,
  // }) : super(key: key);

  ScrollController _sc;
  Carpark carpark;

  CarParkDetails(this._sc, this.carpark);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: ListView(
        controller: _sc,
        children: <Widget>[
          // SizedBox(
          //   height: 12.0,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Container(
          //       width: 30,
          //       height: 5,
          //       decoration: BoxDecoration(
          //           color: Colors.grey[300],
          //           borderRadius: BorderRadius.all(Radius.circular(12.0))),
          //     ),
          //   ],
          // ),
          SizedBox(
            height: 18.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              "Carkpark Name",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 24.0,
              ),
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Address",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.grey)),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  children: [
                    Text(
                      "40 free spots",
                      softWrap: true,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("\$2.40/hr",
                        softWrap: true,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(color: Colors.blueAccent)),
            color: Colors.blueAccent,
            textColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            onPressed: () {},
            child: Text(
              "Bring me there",
              style: TextStyle(
                fontSize: 28.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

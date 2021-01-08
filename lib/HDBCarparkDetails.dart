import 'package:flutter/material.dart';
import 'package:hacknroll2021/AvailableLots.dart';
import 'package:hacknroll2021/GoogleMapsButton.dart';
import 'package:hacknroll2021/HDBCarpark.dart';
import 'ModelLoader.dart';

class HDBCarParkDetails extends StatelessWidget {
  // const CarParkDetails({
  //   Key key,
  // }) : super(key: key);

  ScrollController _sc;
  HDBCarpark carpark;
  ModelLoader _modelLoader;

  HDBCarParkDetails(this._sc, this.carpark, this._modelLoader);

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
              carpark.development ?? "",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 21.0,
              ),
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          carpark.system,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.grey),
                        ),
                        Text(
                          carpark.carparktype,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.grey),
                        ),
                        Text(
                          "NIGHT PARKING: ${carpark.nightParking}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.grey),
                        ),
                        Text(
                          "SHORT-TERM: ${carpark.shortTermParking}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.grey),
                        ),
                      ],
                    ),
                    AvailableLots(carpark: carpark, modelLoader: _modelLoader,),
                  ],
                ),
                Text(
                  "FREE PARKING: ${carpark.freeParking}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
//          FlatButton(
//            shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(8.0),
//                side: BorderSide(color: Colors.blueAccent)),
//            color: Colors.blueAccent,
//            textColor: Colors.white,
//            padding: EdgeInsets.symmetric(vertical: 8.0),
//            onPressed: () {},
//            child: Text(
//              "Bring me there",
//              style: TextStyle(
//                fontSize: 28.0,
//              ),
//            ),
//          ),
          GoogleMapsButton(null, carpark.location),
        ],
      ),
    );
  }
}

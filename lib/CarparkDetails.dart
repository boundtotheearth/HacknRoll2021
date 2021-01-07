import 'package:flutter/material.dart';
import './Carpark.dart';

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
              carpark.development ?? "",
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
                Text(carpark.agency ?? "",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.grey)),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  children: [
                    Text(
                      "${carpark.availableLots ?? 0} free spots",
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

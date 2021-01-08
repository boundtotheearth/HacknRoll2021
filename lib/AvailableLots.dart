import 'package:flutter/material.dart';
import 'Carpark.dart';

class AvailableLots extends StatefulWidget {
  @override
  _AvailableLotsState createState() => _AvailableLotsState();
  const AvailableLots({
    Key key,
    @required this.carpark,
  }) : super(key: key);

  final Carpark carpark;
}

class _AvailableLotsState extends State<AvailableLots> {
  bool _isAvailableLots = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: _isAvailableLots? Column(
        children: [
          Text(
            "AVAILABLE LOTS" ?? "",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Text(
            "${widget.carpark.availableLots ?? 0}",
            softWrap: true,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          ),
        ],
      ): Column(
        children: [
          Text(
            "EXPECTED LOTS" ?? "",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Text(
            "${widget.carpark.availableLots ?? 0}",
            softWrap: true,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          ),
        ],
      ),
      onTap: () {
        setState(() {
          _isAvailableLots = !_isAvailableLots;
          print(_isAvailableLots);
        });
      },
    );
  }
}

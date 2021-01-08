import 'package:flutter/material.dart';
import 'Carpark.dart';
import 'ModelLoader.dart';

class AvailableLots extends StatefulWidget {
  @override
  _AvailableLotsState createState() => _AvailableLotsState();
  const AvailableLots({
    Key key,
    @required this.carpark,
    @required this.modelLoader,
  }) : super(key: key);

  final Carpark carpark;
  final ModelLoader modelLoader;
}

class _AvailableLotsState extends State<AvailableLots> {
  bool _isAvailableLots = true;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: GestureDetector(
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
      ),
    );
  }
}

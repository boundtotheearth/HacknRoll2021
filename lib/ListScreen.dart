import 'package:flutter/material.dart';
import 'package:hacknroll2021/CarparkList.dart';
import 'package:hacknroll2021/MapWidget.dart';

class ListScreen extends StatefulWidget {
  ListScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: CarparkList()
    );
  }
}
import 'package:flutter/material.dart';
import 'package:hacknroll2021/Carpark.dart';
import 'package:hacknroll2021/ListScreen.dart';
import 'package:hacknroll2021/Location.dart';
import 'package:hacknroll2021/MapScreen.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();
  runApp(MyApp());
  LocationService locator = new LocationService();
  List<Carpark> lst = await locator.returnNearestCarparkList();
  // String finalURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=pasir&key=AIzaSyDJhKz-NeJuifrt1nljoIW9udShfkmUuWM';
  // http.Response response = await http.get(finalURL);
  // print(response.body);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Hack & Roll 2021'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                child: Text("MapScreen"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return MapScreen(
                        title: "Map",
                      );
                    }),
                  );
                }),
            ElevatedButton(
                child: Text("ListScreen"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return ListScreen(
                        title: "Carpark List",
                      );
                    }),
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

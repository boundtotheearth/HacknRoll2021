import 'package:flutter/material.dart';
import 'package:hacknroll2021/Carpark.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';
import 'dart:convert';

class Place {
  String description;
  String placeId;

  Place(String description, String placeId) {
    this.description = description;
    this.placeId = placeId;
  }
}

final Map<String, String> headers = {
  'MapKey': FlutterConfig.get('MAPS_API_KEY')
};

Future<List<Place>> fetchData(String query) async {
  int skip = 0;
  bool stop = false;
  List<Place> placeList = [];

  String finalURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?components=country:sg&input=${query}&key=${headers['MapKey']}';
  http.Response response = await http.get(finalURL, headers: headers);

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    List<dynamic> rawList = data['predictions'];
    rawList.forEach((element) {
      placeList.add(Place(element['description'], element['place_id']));
    });

    if (rawList.length < 500) {
      stop = true;
    }
    print(response.body);
  } else {
    throw Exception("Failed to load data");
  }

  return placeList;
}

Widget buildFloatingSearchBar(BuildContext context) {
  final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

  return FloatingSearchBar (
    hint: 'Search...',
    scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
    transitionDuration: const Duration(milliseconds: 800),
    transitionCurve: Curves.easeInOut,
    physics: const BouncingScrollPhysics(),
    axisAlignment: isPortrait ? 0.0 : -1.0,
    openAxisAlignment: 0.0,
    maxWidth: isPortrait ? 600 : 500,
    debounceDelay: const Duration(milliseconds: 500),
    onQueryChanged: (query) async {
      List<Place> buildList = await fetchData(query);
      for (int i = 0; i < buildList.length; i++) {
        print(buildList.elementAt(i).description);
      }
    },
    // Specify a custom transition to be used for
    // animating between opened and closed stated.
    transition: CircularFloatingSearchBarTransition(),
    actions: [
      FloatingSearchBarAction(
        showIfOpened: false,
        child: CircularButton(
          icon: const Icon(Icons.place),
          onPressed: () {
            
          },
        ),
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ],
    builder: (context, transition) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: Colors.white,
          elevation: 4.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: Colors.accents.map((color) {
              return Container(height: 112, color: color);
            }).toList(),
          ),
        ),
      );
    },
  );
}
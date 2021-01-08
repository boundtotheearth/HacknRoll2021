import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './Place.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';
import 'dart:convert';

class SearchBarWrapper extends StatefulWidget {
  @override
  _SearchBarWrapperState createState() => _SearchBarWrapperState();
}

class _SearchBarWrapperState extends State<SearchBarWrapper> {
  final Map<String, String> headers = {
    'MapKey': FlutterConfig.get('MAPS_API_KEY')
  };

  List<Place> places = [];

  Future<List<Place>> fetchData(String query) async {
    int skip = 0;
    bool stop = false;
    List<Place> placeList = [];

    String finalURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?components=country:sg&input=${query}&key=${headers['MapKey']}';
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
    } else {
      throw Exception("Failed to load data");
    }

    return placeList;
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
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
        setState(() {
          places = buildList;
        });
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: places.map((place) {
                return Container(
                  height: 30,
                  child: Text(
                    place.description,
                    softWrap: false,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )
                  )
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

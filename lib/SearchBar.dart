import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './Place.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';
import 'dart:convert';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';

class SearchBarWrapper extends StatefulWidget {
  @override
  _SearchBarWrapperState createState() => _SearchBarWrapperState();
}

class _SearchBarWrapperState extends State<SearchBarWrapper> {
  final Map<String, String> headers = {
    'MapKey': FlutterConfig.get('MAPS_API_KEY')
  };

  List<Place> places = [];

  final controller = FloatingSearchBarController();

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
    return buildSearchBar();
  }

  void onQueryChanged(String query) async {
    List<Place> buildList = await fetchData(query);
    setState(() {
      places = buildList;
    });
  }

  Widget buildSearchBar() {
    final actions = [
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
    ];

    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
        automaticallyImplyBackButton: false,
        controller: controller,
        clearQueryOnClose: true,
        hint: 'Search...',
        iconColor: Colors.grey,
        transitionDuration: const Duration(milliseconds: 500),
        transitionCurve: Curves.easeInOutCubic,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        maxWidth: isPortrait ? 600 : 500,
        actions: actions,
        progress: false,
        debounceDelay: const Duration(milliseconds: 500),
        onQueryChanged: onQueryChanged,
        scrollPadding: EdgeInsets.zero,
        transition: CircularFloatingSearchBarTransition(),
        builder: (context, _) => buildExpandableBody(),
      );
  }

  Widget buildExpandableBody() {
    return Material(
      color: Colors.white,
      elevation: 4.0,
      borderRadius: BorderRadius.circular(8),
      child: ImplicitlyAnimatedList<Place>(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        items: places,
        areItemsTheSame: (a, b) => a == b,
        itemBuilder: (context, animation, place, i) {
          return SizeFadeTransition(
            animation: animation,
            child: buildItem(context, place),
          );
        },
        updateItemBuilder: (context, animation, place) {
          return FadeTransition(
            opacity: animation,
            child: buildItem(context, place),
          );
        },
        insertDuration: Duration(milliseconds: 250),
        removeDuration: Duration(milliseconds: 250),
        updateDuration: Duration(milliseconds: 250),
      ),
    );
  }

  Widget buildItem(BuildContext context, Place place) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            FloatingSearchBar.of(context).close();
            Future.delayed(
              const Duration(milliseconds: 500),
                  () => places.clear(),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SizedBox(
                  width: 36,
                  child: Icon(Icons.place, key: Key('place')),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.description,
                        style: textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

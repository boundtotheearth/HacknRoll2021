import 'dart:convert';

import 'package:hacknroll2021/Carpark.dart';
import 'package:http/http.dart' as http;

class DataSource {
  final String sourceURL =
      'http://datamall2.mytransport.sg/ltaodataservice/CarParkAvailabilityv2';

  final Map<String, String> headers = {
    'AccountKey' : 'YJnS3P+qRAyxvHFOPwvtpA=='
  };

  Future<http.Response> fetchDataRaw() {
    return http.get(sourceURL, headers: headers);
  }

  Future<List<Carpark>> fetchData() async {
    int skip = 0;
    bool stop = false;
    List<Carpark> carparkList = [];

    do {
      String finalURL = sourceURL + "?\$skip=$skip";
      http.Response response = await http.get(finalURL, headers: headers);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> rawList = data['value'];
        rawList.forEach((element) {
          carparkList.add(Carpark.fromJson(element));
        });
        print(rawList);

        if(rawList.length < 500) {
          stop = true;
        }
      } else {
        throw Exception("Failed to load data");
      }
      skip += 500;
      print(finalURL);
    } while (!stop);

    return carparkList;
  }
}
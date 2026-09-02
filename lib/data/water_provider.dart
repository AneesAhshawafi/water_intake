import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:water_intake/constants/strings.dart';
import 'package:water_intake/models/water_model.dart';

class WaterProvider extends ChangeNotifier {
  List<WaterModel> waterDataList = [];
  bool isLoading = false;

  void addWater(WaterModel water) async {
    final url = Uri.https(baseUrl, 'water.json');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'amount': double.parse(water.amount.toString()),
        'unit': 'ml',
        'dateTime': DateTime.now().toString(),
      }),
    );
    if (response.statusCode == 200) {
      final extractData = json.decode(response.body) as Map<String, dynamic>;
      waterDataList.add(
        WaterModel(
          id: extractData['name'],
          amount: water.amount,
          dateTime: water.dateTime,
          unit: water.unit,
        ),
      );
    }
    notifyListeners();
  }

  Future<void> getWater() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(baseUrl, 'water.json');
    final response = await http.get(url);

    if (response.statusCode == 200 &&
        response.body.isNotEmpty &&
        response.body != 'null') {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<WaterModel> loadedList = [];

      for (var element in extractedData.entries) {
        loadedList.add(
          WaterModel(
            id: element.key,
            amount: (element.value['amount'] as num).toDouble(),
            dateTime: DateTime.parse(element.value['dateTime']),
            unit: element.value['unit'],
          ),
        );
      }
      waterDataList = loadedList;
    }

    isLoading = false;
    notifyListeners();
  }

  void delete(WaterModel waterData) async {
    final url = Uri.https(baseUrl, 'water/${waterData.id}.json');
    final response = await http.delete(url);
    if (response.statusCode == 200) {}
    waterDataList.removeWhere((element) => element.id == waterData.id);
    notifyListeners();
  }

  DateTime getStartOfWeek() {
    DateTime? startOfWeek;
    // get the current date
    DateTime dateTime = DateTime.now();
    for (int i = 0; i < 7; i++) {
      if (getWeekDay(dateTime.subtract(Duration(days: i))).toLowerCase() ==
          'sun') {
        startOfWeek = dateTime.subtract(Duration(days: i));
        break;
      }
    }
    return startOfWeek ?? dateTime;
  }

  String getWeekDay(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tues';
      case 3:
        return 'Wed';
      case 4:
        return 'Thur';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }
}
// class WaterProvider extends ChangeNotifier {
//   List<WaterModel> waterDataList = [];
//   bool isLoading = false;
// }

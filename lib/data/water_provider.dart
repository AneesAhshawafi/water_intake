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
    await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'amount': double.parse(water.amount.toString()),
        'unit': 'ml',
        'dateTime': DateTime.now().toString(),
      }),
    );

    notifyListeners();
  }

  // Future<List<WaterModel>> getWater() async {
  //   final url = Uri.https(baseUrl, 'water.json');
  //   final response = await http.get(url);
  //   if (response.statusCode == 200 && response.body.isNotEmpty) {
  //     // return the data
  //     final extractedData = json.decode(response.body) as Map<String, dynamic>;
  //     for (var element in extractedData.entries) {
  //       waterDataList.add(
  //         WaterModel(
  //           amount: element.value['amount'],
  //           dateTime: DateTime.parse(element.value['dateTime']),
  //           unit: element.value['unit'],
  //         ),
  //       );
  //     }
  //   }
  //   notifyListeners();
  //   return waterDataList;
  // }
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
}

// class WaterProvider extends ChangeNotifier {
//   List<WaterModel> waterDataList = [];
//   bool isLoading = false;
// }

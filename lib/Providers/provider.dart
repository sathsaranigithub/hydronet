import 'package:d_chart/commons/data_model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyModel extends ChangeNotifier {
  double light = 0.0;
  double temperature = 0.0;
  double water = 0.0;
  double media = 0.0;
  double yieldPredict = 0.0;
  String? email = "";
  List<FlSpot> ordinalList = [];
  List<FlSpot> ordinalList2 = [];
  List<FlSpot> ordinalList3 = [];
  List<FlSpot> ordinalList4 = [];
  List<Map<String, dynamic>> fetchedTableRecords = [];

  void updateLight(double newValue) {
    light = newValue;
    notifyListeners();
  }
  void updateFetchedTableRecords(List<Map<String, dynamic>> newValue) {
    fetchedTableRecords = newValue;
    notifyListeners();
  }

  void updateWater(double newValue) {
    water = newValue;
    notifyListeners();
  }

  void updateTemperature(double newValue) {
    temperature = newValue;
    notifyListeners();
  }

  void updateMedia(double newValue) {
    media = newValue;
    notifyListeners();
  }

  void updateYield(double newValue) {
    yieldPredict = newValue;
    notifyListeners();
  }

  void updateEmail(String? newValue) {
    email = newValue;
    notifyListeners();
  }

  void updateOrdinalList(List<FlSpot> newValue) {
    ordinalList = newValue;
    notifyListeners();
  }

  void updateOrdinalList2(List<FlSpot> newValue) {
    ordinalList2 = newValue;
    notifyListeners();
  }

  void updateOrdinalList3(List<FlSpot> newValue) {
    ordinalList3 = newValue;
    notifyListeners();
  }

  void updateOrdinalList4(List<FlSpot> newValue) {
    ordinalList4 = newValue;
    notifyListeners();
  }
}

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_chart/commons/data_model/data_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:lettus/Providers/provider.dart';
import 'package:lettus/Screens/yieldGraph.dart';
import 'package:lettus/Utils/appColors.dart';
import 'package:lettus/Utils/constValues.dart';
import 'package:lettus/Utils/pageNavigations.dart';
import 'package:lettus/Widgets/popUpMsgBox.dart';
import 'package:lettus/Widgets/snackBar.dart';

class PredictService {
  Future<void> getPrediction(BuildContext context) async {
    final String url = ConstValues.link;
    final formProvider = Provider.of<MyModel>(context, listen: false);

    final Map<String, String> body = {
      "Light_Intensity": formProvider.light.toString(),
      "Ambient_Temperature": formProvider.temperature.toString(),
      "Water_pH": formProvider.water.toString(),
      "Media_EC": formProvider.media.toString(),
    };

    final Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(body),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        double predictedValue = data['predicted'];

        print('Predicted Value: $predictedValue');
        formProvider.updateYield(predictedValue);
        showWinningDialog(context, predictedValue.toStringAsFixed(2));
      } else {
        print('Failed to get prediction. Status code: ${response.statusCode}');
        SnackbarUtils.showDefaultSnackBar(
            context, "Error: ${response.statusCode}", AppColors.errorcolor);
      }
    } catch (e) {
      print('Error: $e');
      SnackbarUtils.showDefaultSnackBar(
          context, ConstValues.wentWrongMsg, AppColors.errorcolor);
    }
  }

  Future<void> savePrediction(BuildContext context) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final formProvider = Provider.of<MyModel>(context, listen: false);

    try {
      await firestore.collection('yieldPrediction').add({
        'email': formProvider.email,
        'lightIntensity': formProvider.light,
        'ambientTemperature': formProvider.temperature,
        'waterPh': formProvider.water,
        'mediaEC': formProvider.media,
        'yield': formProvider.yieldPredict
      });
      Navigator.pop(context);

      NavigationUtils.frontNavigation(context, const YieldGraph());
    } catch (error) {
      SnackbarUtils.showDefaultSnackBar(
          context, error.toString(), AppColors.errorcolor);
      throw Exception(" $error");
    }
  }

 Future<void> fetchLightData(BuildContext context) async {
    final formProvider = Provider.of<MyModel>(context, listen: false);

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('yieldPrediction')
          .where('email', isEqualTo: formProvider.email)
          .get();

      List<FlSpot> records = [];

      int recordIndex = 1;
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        double light = (data['lightIntensity'] is int)
            ? (data['lightIntensity'] as int).toDouble()
            : (data['lightIntensity'] ?? 0.0);
        double yieldPrediction = (data['yield'] is int)
            ? (data['yield'] as int).toDouble()
            : (data['yield'] ?? 0.0);

        print(
            'Record $recordIndex - Light Intensity: $light, Yield: $yieldPrediction');

        records.add(FlSpot((light / 1000), yieldPrediction));

        recordIndex++;
      }
      records.sort((a, b) => a.x.compareTo(b.x));
      formProvider.ordinalList = records;
    } catch (e) {
      SnackbarUtils.showDefaultSnackBar(
          context, ConstValues.wentWrongMsg, AppColors.errorcolor);
      print('Error fetching data: $e');
    }
  }

  Future<void> fetchMediaData(BuildContext context) async {
    final formProvider = Provider.of<MyModel>(context, listen: false);

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('yieldPrediction')
          .where('email', isEqualTo: formProvider.email)
          .get();

      List<FlSpot> records = [];

      int recordIndex = 1;
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        double light = (data['mediaEC'] is int)
            ? (data['mediaEC'] as int).toDouble()
            : (data['mediaEC'] ?? 0.0);
        double yieldPrediction = (data['yield'] is int)
            ? (data['yield'] as int).toDouble()
            : (data['yield'] ?? 0.0);

        print(
            'Record $recordIndex - Light Intensity: $light, Yield: $yieldPrediction');

        records.add(FlSpot(light, yieldPrediction));

        recordIndex++;
      }
      records.sort((a, b) => a.x.compareTo(b.x));
      formProvider.ordinalList2 = records;
    } catch (e) {
      SnackbarUtils.showDefaultSnackBar(
          context, ConstValues.wentWrongMsg, AppColors.errorcolor);
      print('Error fetching data: $e');
    }
  }

  Future<void> fetchWaterData(BuildContext context) async {
    final formProvider = Provider.of<MyModel>(context, listen: false);

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('yieldPrediction')
          .where('email', isEqualTo: formProvider.email)
          .get();

      List<FlSpot> records = [];

      int recordIndex = 1;
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        double light = (data['waterPh'] is int)
            ? (data['waterPh'] as int).toDouble()
            : (data['waterPh'] ?? 0.0);
        double yieldPrediction = (data['yield'] is int)
            ? (data['yield'] as int).toDouble()
            : (data['yield'] ?? 0.0);

        print(
            'Record $recordIndex - Light Intensity: $light, Yield: $yieldPrediction');

        records.add(FlSpot(light, yieldPrediction));

        recordIndex++;
      }
      records.sort((a, b) => a.x.compareTo(b.x));

      formProvider.ordinalList3 = records;
    } catch (e) {
      SnackbarUtils.showDefaultSnackBar(
          context, ConstValues.wentWrongMsg, AppColors.errorcolor);
      print('Error fetching data: $e');
    }
  }

  Future<void> fetchTemperatureData(BuildContext context) async {
    final formProvider = Provider.of<MyModel>(context, listen: false);

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('yieldPrediction')
          .where('email', isEqualTo: formProvider.email)
          .get();

      List<FlSpot> records = [];

      int recordIndex = 1;
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        double light = (data['ambientTemperature'] is int)
            ? (data['ambientTemperature'] as int).toDouble()
            : (data['ambientTemperature'] ?? 0.0);
        double yieldPrediction = (data['yield'] is int)
            ? (data['yield'] as int).toDouble()
            : (data['yield'] ?? 0.0);

        print(
            'Record $recordIndex - Light Intensity: $light, Yield: $yieldPrediction');

        records.add(FlSpot(light, yieldPrediction));

        recordIndex++;
      }
      records.sort((a, b) => a.x.compareTo(b.x));
      formProvider.ordinalList4 = records;
    } catch (e) {
      SnackbarUtils.showDefaultSnackBar(
          context, ConstValues.wentWrongMsg, AppColors.errorcolor);
      print('Error fetching data: $e');
    }
  }

  void showWinningDialog(BuildContext context, String result) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: Popupmsgbox(
              t1: 'Yield Prediction result',
              t2: '$result (kg/sqm)',
              t3: 'Save record',
              onTap: () {
                Navigator.pop(context);
              },
              onTap1: () async {
                savePrediction(context);
              }),
        );
      },
    );
  }
  Future<void> fetchData(BuildContext context) async {
    final formProvider = Provider.of<MyModel>(context, listen: false);

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('yieldPrediction')
          .where('email', isEqualTo: formProvider.email)
          .get();

      List<Map<String, dynamic>> fetchedRecords = querySnapshot.docs.map((doc) {
        return {
          'Temp': doc['ambientTemperature'],
          'Light': doc['lightIntensity'],
          'MediaEC': doc['mediaEC'],
          'Water': doc['waterPh'],
          'Yield': doc['yield'],
        };
      }).toList();

      formProvider.updateFetchedTableRecords(fetchedRecords);
    } catch (e) {
      SnackbarUtils.showDefaultSnackBar(
          context, ConstValues.wentWrongMsg, AppColors.errorcolor);
      print('Error fetching data: $e');
    }
  }
}

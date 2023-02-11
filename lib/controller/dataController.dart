import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class dataController extends GetxController {
  static dataController instance = Get.find();
  List? data;
  var getApiUrl = "https://reqres.in/api/users?page=2";

  void getData() async {
    try {
      var response = await http
          .get(Uri.parse(getApiUrl), headers: {"Accept": "application/json"});
      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson['data'];
    } catch (e) {
      Get.snackbar(
        "Get Data",
        "Data message",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text("Get Data Failed"),
        messageText: Text(
          e.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }
}

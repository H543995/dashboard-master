import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

SharedPreferences prefs;
const Color primaryColor = Color(0xffFF0000);
const String token = "wjeiwenwejwkejwke98w9e8wewnew8wehwenj232jh32j3h2j3h2j";

final String path_api = "http://192.168.42.130/flutterrestaurant/api/";
final String path_images = "http://192.168.42.130/flutterrestaurant/images/";
final String imagesFood = path_images + "food/";
final String imagesCus = path_images + "cus/";




String G_use_id_val = "";


final String G_use_id = "use_id";
final String G_use_name = "use_name";
final String G_use_mobile = "use_mobile";
final String G_use_image = "use_image";


String G_ad_id_val = "";

final String G_ad_id = "ad_id";
final String G_ad_name = "ad_name";
final String G_ad_mobile = "ad_mobile";
final String G_ad_image = "ad_image";

Future<bool> checkConnection() async {
  try {
    return true;
    final result = await InternetAddress.lookup("google.com");
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print("connect");
      return true;
    } else {
      print("not connect");
      return false;
    }
  } on SocketException catch (_) {
    print("not connect");
    return false;
  }
}

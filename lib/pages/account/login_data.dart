import 'dart:convert';
import 'package:dashboard/pages/home/home_use.dart';
import 'package:dashboard/pages/home/home_admin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:dashboard/pages/config.dart';
import 'dart:async';

Future<bool> loginUsers( String use_mobile, String use_pwd, BuildContext context) async {

  String url = path_api +"users/login.php?use_mobile=" + use_mobile +"&use_pwd=" + use_pwd +"&token=" + token;

  http.Response respone = await http.get(url);
  print(respone.body);
  if (json.decode(respone.body)["code"] == "200") {
    Map arr = json.decode(respone.body)["message"];

    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.setString(G_use_id, arr["use_id"]);
    sh.setString(G_use_name, arr["use_name"]);
    sh.setString(G_use_image, arr["use_image"]);
    sh.setString(G_use_mobile, arr["use_mobile"]);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home_use()));

    print("success");
    return true;
  } else {
    print("Failer");
    return false;
  }
}
Future<bool> loginmanger( String ad_mobile, String ad_pwd, BuildContext
context)
async {

  String url = path_api +"admin/login.php?ad_mobile=" + ad_mobile
      +"&ad_pwd=" + ad_pwd +"&token=" + token;

  http.Response respone = await http.get(url);
  print(respone.body);
  if (json.decode(respone.body)["code"] == "200") {
    Map arr = json.decode(respone.body)["message"];

    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.setString(G_ad_id, arr["ad_id"]);
    sh.setString(G_ad_name, arr["ad_name"]);
    sh.setString(G_ad_image, arr["ad_image"]);
    sh.setString(G_ad_mobile, arr["ad_mobile"]);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => home_admin()));

    print("success");
    return true;
  } else {
    print("Failer");
    return false;
  }
}
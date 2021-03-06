import "package:dashboard/pages/config.dart";
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> SaveData(Map arrInsert, String urlPage, BuildContext context,
		Widget Function() movePage, String type) async {
	String url = path_api + "${urlPage}?token=" + token;

	http.Response respone = await http.post(url, body: arrInsert);

	if (json.decode(respone.body)["code"] == "200") {

		var arr = json.decode(respone.body)["message"];
		print('sddddd');
		print(respone.body);

		SharedPreferences sh = await SharedPreferences.getInstance();
		sh.setString(G_use_id, arr["use_id"]);
		sh.setString(G_use_name, arr["use_name"]);
		sh.setString(G_use_image, arr["use_image"]);
		sh.setString(G_use_mobile, arr["use_mobile"]);

		print(respone.body);
		if (type == "insert") {
			Navigator.push(
					context, MaterialPageRoute(builder: (context) => movePage()));
		} else {
			Navigator.pop(context);
		}
		print("success");
		return true;
	} else {
		print("Failer");
		return false;
	}
}
Future<bool> SaveData1(Map arrInsert, String urlPage, BuildContext context,
		Widget Function() movePage, String type) async {
	String url = path_api + "${urlPage}?token=" + token;

	http.Response respone = await http.post(url, body: arrInsert);
	print('sddddd');
	print(respone.body);
	if (json.decode(respone.body)["code"] == "200") {
		print('sddddd');
		print(respone.body);
		if (type == "insert") {
			Navigator.push(
					context, MaterialPageRoute(builder: (context) => movePage()));
		} else {
			Navigator.pop(context);
		}
		print("success");
		return true;
	} else {
		print("Failer");
		return false;
	}
}

Future<bool> uploadFileWithData(
    dynamic imageFile,
    Map arrInsert,
    String urlPage,
    BuildContext context,
    Widget Function() movePage,
    String type) async {
  if (imageFile == null) {
    await SaveData(arrInsert, urlPage, context, movePage, type);
    return false;
  }
  var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));

  var length = await imageFile.length();
  String url = path_api + "${urlPage}?token=" + token;
  var uri = Uri.parse(url);
  print(uri.path);
  var request = new http.MultipartRequest("POST", uri);
  var multipartFile = new http.MultipartFile("file", stream, length,
      filename: basename(imageFile.path));
  for (var entry in arrInsert.entries) {
    request.fields[entry.key] = entry.value;
  }

  request.files.add(multipartFile);
  var response = await request.send();

  if (response.statusCode == 200) {
    print("Send succefull");
    if (type == "update") {
      Navigator.pop(context);
    } else if (type == "insert") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => movePage()));
    }
    return true;
  } else {
    return false;
    print("not send");
  }
}
Future<bool> uploadFileWithData1(
		dynamic imageFile,
		Map arrInsert,
		String urlPage,
		BuildContext context,
		Widget Function() movePage,
		String type) async {
	if (imageFile == null) {
		await SaveData(arrInsert, urlPage, context, movePage, type);
		return false;
	}
	var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));

	var length = await imageFile.length();
	String url = path_api + "${urlPage}?token=" + token;
	var uri = Uri.parse(url);
	print(uri.path);
	var request = new http.MultipartRequest("POST", uri);
	var multipartFile = new http.MultipartFile("file", stream, length,
			filename: basename(imageFile.path));
	for (var entry in arrInsert.entries) {
		request.fields[entry.key] = entry.value;
	}

	request.files.add(multipartFile);
	var response = await request.send();

	if (response.statusCode == 200) {
		print("Send succefull");
		if (type == "update") {
			Navigator.pop(context);
		} else if (type == "insert") {
			Navigator.push(
					context, MaterialPageRoute(builder: (context) => movePage()));
		}
		return true;
	} else {
		return false;
		print("not send");
	}
}
Future<List> getData(
    int count, String urlPage, String strSearch, String param) async {
  String url = path_api +
      "${urlPage}?${param}txtsearch=${strSearch}&start=${count}&end=10&token=" +
      token;
  print(url);
  http.Response respone = await http.post(url);

  if (json.decode(respone.body)["code"] == "200") {
    {
      List arr = (json.decode(respone.body)["message"]);
      print(arr);
      return arr;
    }
  }
}

Future<List> getData2(
		int start, int end, String urlPage, String strSearch, String param) async {
	String url = path_api +
			"${urlPage}?${param}txtsearch=${strSearch}&start=${start}&end=${end}&token=" +
			token;
	print(url);
	http.Response respone = await http.post(url);

	if (json.decode(respone.body)["code"] == "200") {
		{
			List arr = (json.decode(respone.body)["message"]);
			print(arr);
			return arr;
		}
	} else {
		return null;
	}
}
Future<Map> SaveDataList(
    Map arrInsert, String urlPage, BuildContext context, String type) async {
  String url = path_api + "${urlPage}?token=" + token;

  http.Response respone = await http.post(url, body: arrInsert);
  print(respone.body);
  if (json.decode(respone.body)["code"] == "200") {
    Map arr = json.decode(respone.body)["message"];

    print("success");
    return arr;
  } else {
    print("Failer");
    return null;
  }
}
Future<List> getData_bill(
    int start, int end, String urlPage, String strSearch, String param) async {
  String url = path_api +
      "${urlPage}?${param}txtsearch=${strSearch}&start=${start}&end=${end}&token=" +
      token;
  print(url);
  http.Response respone = await http.post(url);

  if (json.decode(respone.body)["code"] == "200") {
    {
      List arr = (json.decode(respone.body)["message"]);
      print(arr);
      return arr;
    }
  } else {
    return null;
  }
}

Future<bool> deleteData(String col_id, String val_id, String urlPage) async {
  String url = path_api + "${urlPage}?${col_id}=${val_id}&token=" + token;
  print(url);
  http.Response respone = await http.post(url);

  if (json.decode(respone.body)["code"] == "200") {
    return true;
  } else {
    return false;
  }
}

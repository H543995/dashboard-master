import 'dart:convert';

import 'package:dashboard/pages/h1/Food_ad.dart';
import 'package:dashboard/pages/provider/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:provider/provider.dart';

List<UsersData> userList = null;

class UsersData {
  String use_id;
  String cat_name;
  String use_name;
  String use_pwd;
  String use_mobile;
  bool use_active;
  String use_lastdate;
  String use_note;
  UsersData(
      {this.use_id,
      this.use_name,
      this.cat_name,
      this.use_pwd,
      this.use_lastdate,
      this.use_mobile,
      this.use_active,
      this.use_note});
}

class SingleUser_ad extends StatelessWidget {
  int use_index;
  String use_id;
  UsersData users;

  SingleUser_ad({this.use_index, this.use_id, this.users});
  @override
  Widget build(BuildContext context) {
    var providerUser = Provider.of<LoadingControl>(context);
    return Card(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {

              Navigator.push(
                  context,
                  MaterialPageRoute(

                      builder: (context) => new Food_ad(
                            use_id: users.use_id,
                          )));
            },
            child: Container(
              child: ListTile(
                title: Text(
                  users.use_name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(users.cat_name),

                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

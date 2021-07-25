import 'dart:convert';
import 'package:dashboard/pages/provider/loading.dart';
import 'package:dashboard/pages/users/users.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:dashboard/pages/config.dart';
import 'dart:async';

import 'package:provider/provider.dart';

import '../function.dart';
import 'edit_admin.dart';

List<adminData> adminList = null;

class adminData {
  String ad_id;
  String ad_name;
  String ad_pwd;
  String ad_mobile;
  bool ad_validity;
  String ad_lastdate;
  String ad_email;
  adminData(
      {this.ad_id,
      this.ad_name,
      this.ad_pwd,
      this.ad_lastdate,
      this.ad_mobile,
      this.ad_validity,
      this.ad_email});
}

class SingleUser extends StatelessWidget {
  int ad_index;
  adminData admin;
  SingleUser({this.ad_index, this.admin});
  @override
  Widget build(BuildContext context) {
    var providerUser = Provider.of<LoadingControl>(context);
    return Card(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              adminList.removeAt(ad_index);
              deleteData("ad_id", admin.ad_id, "admin/delete_admin.php");
              providerUser.add_loading();
            },
            child: Container(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
          ),
          Container(
            child: ListTile(
              title: Text(
                admin.ad_name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(admin.ad_mobile), Text(admin.ad_lastdate)]),
              trailing: Container(
                width: 30.0,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new EditUsers(
                                      ad_index: ad_index,
                                      admin: admin,
                                    )));
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: FaIcon(
                          FontAwesomeIcons.edit,
                          color: Colors.white,
                          size: 16,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

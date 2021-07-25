import 'package:dashboard/pages/category/category.dart';
import 'package:dashboard/pages/config.dart';
import 'package:dashboard/pages/delivery/delivery.dart';
import 'package:dashboard/pages/drawer/mydrawer.dart';
import 'package:dashboard/pages/drawer/mydrawer_use.dart';
import 'package:dashboard/pages/food/food.dart';
import 'package:dashboard/pages/test1/teset2.dart';
import 'package:dashboard/pages/test1/teset3.dart';
import 'package:dashboard/pages/users/users.dart';
import 'package:dashboard/pages/users/users_data.dart';

import 'package:flutter/material.dart';

class Home_use extends StatefulWidget {
  int use_id;
  final String cat_name;

  Home_use({this.use_id, this.cat_name,});

  @override

  _Home_useState createState() => _Home_useState();
}

class _Home_useState extends State<Home_use> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text("لوحه تحكم صاحب المحل"),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey[100],
        endDrawer: MyDrawer_use(),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            children: <Widget>[

              Row(
                children: <Widget>[
                  new Expanded(
                      child: GestureDetector(
                          /*onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Users()));
                          },*/
                          child: Container(
                            margin: EdgeInsets.all(5.0),
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Column(
                              children: <Widget>[
                                new Icon(
                                  Icons.home,
                                  size: 80.0,
                                  color: Colors.green,
                                ),
                                new Text(
                                  "المستخدمين",
                                  style: TextStyle(fontSize: 18.0),
                                )
                              ],
                            ),
                          ))),
                  new Expanded(
                      child: GestureDetector(
                    onTap: () {

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Food(
cat_name:widget.cat_name ,
                            use_id:widget.use_id ,



                          )));
                    },
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Column(
                        children: <Widget>[
                          new Icon(
                            Icons.category,
                            size: 80.0,
                            color: Colors.orange,
                          ),
                          new Text(
                            "المنتجات",
                            style: TextStyle(fontSize: 18.0),
                          )
                        ],
                      ),
                    ),
                  )),
                ],
              ),
              Row(
                children: <Widget>[
                  new Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Delivery()));
                    },
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Column(
                        children: <Widget>[
                          new Icon(
                            Icons.fastfood,
                            size: 80.0,
                            color: Colors.red,
                          ),
                          new Text(
                            "الدليفري",
                            style: TextStyle(fontSize: 18.0),
                          )
                        ],
                      ),
                    ),
                  )),
                  new Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Bill()));
                        },
                        child: Container(
                          margin: EdgeInsets.all(5.0),
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Column(
                            children: <Widget>[
                              new Icon(
                                Icons.fastfood,
                                size: 80.0,
                                color: Colors.red,
                              ),
                              new Text(
                                "طلبيات",
                                style: TextStyle(fontSize: 18.0),
                              )
                            ],
                          ),
                        ),
                      )),
                ],
              ),
              Row(
                children: <Widget>[
                  new Expanded(
                      child: Container(
                    margin: EdgeInsets.all(5.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Column(
                      children: <Widget>[
                        new Icon(
                          Icons.notifications,
                          size: 80.0,
                          color: Colors.lime,
                        ),
                        new Text(
                          "الاشعارات",
                          style: TextStyle(fontSize: 18.0),
                        )
                      ],
                    ),
                  )),
                  new Expanded(
                      child: Container(
                    margin: EdgeInsets.all(5.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Column(
                      children: <Widget>[
                        new Icon(
                          Icons.access_alarms,
                          size: 80.0,
                          color: Colors.orange,
                        ),
                        new Text(
                          "الطلبيات قيد التنفيذ",
                          style: TextStyle(fontSize: 18.0),
                        )
                      ],
                    ),
                  )),
                ],
              ),
            ],
          ),
        ));
  }
}

import 'package:dashboard/pages/admin/Admins.dart';
import 'package:dashboard/pages/admin/food_read_ad/food.dart';
import 'package:dashboard/pages/category/category.dart';
import 'package:dashboard/pages/config.dart';
import 'package:dashboard/pages/delivery/delivery.dart';
import 'package:dashboard/pages/drawer/mydrawer.dart';
import 'package:dashboard/pages/h1/catger_insert_ad.dart';


import 'package:flutter/material.dart';

class home_admin extends StatefulWidget {
	@override
	_home_adminState createState() => _home_adminState();
}

class _home_adminState extends State<home_admin> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
				appBar: AppBar(
					backgroundColor: primaryColor,
					title: Text("لوحه تحكم الادمن"),
					centerTitle: true,
				),
				backgroundColor: Colors.grey[100],
				endDrawer: MyDrawer_admin(),
				body: Directionality(
					textDirection: TextDirection.rtl,
					child: ListView(
						children: <Widget>[
							Row(
								children: <Widget>[
									new Expanded(
											child: GestureDetector(
													onTap: () {
														Navigator.push(
																context,
																MaterialPageRoute(
																		builder: (context) => Admins()));
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
																	Icons.home,
																	size: 80.0,
																	color: Colors.green,
																),
																new Text(
																	"الادمن",
																	style: TextStyle(fontSize: 18.0),
																)
															],
														),
													))),
									new Expanded(
											child: GestureDetector(
												onTap: () {
													Navigator.push(context,
															MaterialPageRoute(builder: (context) => catger_read_ad()));
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
																"التصنيفات",
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
											child: Container(
												margin: EdgeInsets.all(5.0),
												padding: EdgeInsets.all(10.0),
												decoration: BoxDecoration(
														color: Colors.white,
														borderRadius: BorderRadius.circular(15.0)),
												child: Column(
													children: <Widget>[
														new Icon(
															Icons.message,
															size: 80.0,
															color: Colors.blue,
														),
														new Text(
															"الطلبيات",
															style: TextStyle(fontSize: 18.0),
														)
													],
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

import 'dart:ui';
import 'package:dashboard/pages/admin/add_admin.dart';
import 'package:dashboard/pages/admin/admin_data.dart';
import 'package:dashboard/pages/component/progress.dart';
import 'package:dashboard/pages/provider/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dashboard/pages/config.dart';
import 'package:dashboard/pages/function.dart';
import 'package:provider/provider.dart';

import '../function.dart';

class Admins extends StatefulWidget {
  @override
  _AdminsState createState() => _AdminsState();
}

class _AdminsState extends State<Admins> {
  ScrollController myScroll;
  GlobalKey<RefreshIndicatorState> refreshKey;
  int i = 0;
  bool loadingList = false;
  void getDataUser(int count, String strSearch) async {
    loadingList = true;
    setState(() {});
    List arr = await getData(count, "admin/readadmin.php", strSearch, "");
    for (int i = 0; i < arr.length; i++) {
      adminList.add(new adminData(
        ad_id: arr[i]["ad_id"],
        ad_name: arr[i]["ad_name"],
        ad_pwd: arr[i]["ad_pwd"],
        ad_mobile: arr[i]["ad_mobile"],
        ad_validity: arr[i]["ad_validity"] == "1" ? true : false,
        ad_lastdate: arr[i]["ad_lastdate"],
        ad_email: arr[i]["ad_email"],
      ));
    }
    loadingList = false;
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myScroll.dispose();
    adminList.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adminList = new List<adminData>();
    myScroll = new ScrollController();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    getDataUser(0, "");

    myScroll.addListener(() {
      if (myScroll.position.pixels == myScroll.position.maxScrollExtent) {
        i += 10;
        getDataUser(i, "");
        print("scroll");
      }
    });
  }

  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text("ادارة اليوزر");

  void _searchPressed(LoadingControl myProv) {
    if (this._searchIcon.icon == Icons.search) {
      this._searchIcon = new Icon(Icons.close);
      this._appBarTitle = new TextField(
        style: TextStyle(color: Colors.white),
        decoration: new InputDecoration(
            prefixIcon: Icon(Icons.search), hintText: "ابحث ..."),
        onChanged: (text) {
          print(text);

          adminList.clear();
          i = 0;
          getDataUser(0, text);
          myProv.add_loading();
        },
      );
    } else {
      this._searchIcon = new Icon(Icons.search);
      this._appBarTitle = new Text("بحث باسم المستخدم");
    }
    myProv.add_loading();
  }

  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<LoadingControl>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: _appBarTitle,
        centerTitle: true,
        actions: [
          Container(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                _searchPressed(myProvider);
              },
              child: _searchIcon,
            ),
          )
        ],
      ),
      backgroundColor: Colors.grey[50],
      body: RefreshIndicator(
        onRefresh: () async {
          i = 0;
          adminList.clear();
          await getDataUser(0, "");
        },
        key: refreshKey,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 0),
                child: ListView.builder(
                  controller: myScroll,
                  itemCount: adminList.length,
                  itemBuilder: (context, index) {
                    final item = adminList[index];
                    return Dismissible(
                      key: Key(item.ad_id),
                      direction: DismissDirection.startToEnd,
                      child: SingleUser(
                        ad_index: index,
                        admin: adminList[index],
                      ),
                      onDismissed: (direction) {
                        adminList.remove(item);
                        deleteData(
                            "ad_id", item.ad_id, "admin/delete_admin.php");
                        myProvider.add_loading();
                      },
                    );
                  },
                ),
              ),
              Positioned(
                  child: loadingList ? circularProgress() : Text(""),
                  bottom: 0,
                  left: MediaQuery.of(context).size.width / 2)
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddUsers()));
                },
                child: Text(
                  "اضافة مستخدم جديد",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              height: 40.0,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(40)),
            ),
          ],
        ),
      ),
    );
  }
}

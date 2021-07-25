import 'dart:ui';

import 'package:dashboard/pages/component/progress.dart';
import 'package:dashboard/pages/function.dart';
import 'package:dashboard/pages/provider/loading.dart';
import 'package:dashboard/pages/users/users_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';

import '../../config.dart';


class insert_use extends StatefulWidget {
  final String cat_name;
  int use_id;

  insert_use({ this.cat_name,this.use_id});

  @override
  _insert_useState createState() => _insert_useState();
}

class _insert_useState extends State<insert_use> {
  ScrollController myScroll;
  GlobalKey<RefreshIndicatorState> refreshKey;

  int i = 0;
  bool loadingList = false;
  void getDataUser(int count, String strSearch) async {
    loadingList = true;
    setState(() {});
    List arr = await getData(count, "users/readuser.php?cat_name=${widget.cat_name}&", strSearch, "");
    for (int i = 0; i < arr.length; i++) {
      userList.add(new UsersData(
        use_id: arr[i]["use_id"],
        cat_name: arr[i]["cat_name"],
        use_name: arr[i]["use_name"],
        use_lastdate: arr[i]["use_lastdate"],
        use_note: arr[i]["use_note"],
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
    userList.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appBarTitle =
    new Text(widget.cat_name, style: TextStyle(color: Colors.black));
    userList = new List<UsersData>();
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
  Widget _appBarTitle ;

  void _searchPressed(LoadingControl myProv) {
    if (this._searchIcon.icon == Icons.search) {
      this._searchIcon = new Icon(Icons.close);
      this._appBarTitle = new TextField(
        style: TextStyle(color: Colors.white),
        decoration: new InputDecoration(
            prefixIcon: Icon(Icons.search), hintText: "ابحث ..."),
        onChanged: (text) {
          print(text);

          userList.clear();
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
          userList.clear();
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
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return
                      SingleUser(
                        use_index: index,
                        users: userList[index],
                        use_id: 'use_id',
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

    );
  }
}

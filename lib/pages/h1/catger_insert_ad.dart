import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard/pages/h1/date_catger_ad.dart';
import 'package:dashboard/pages/provider/loading.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../function.dart';

class catger_read_ad extends StatefulWidget {
  String cat_name;
  catger_read_ad({this.cat_name});

  @override
  _catger_read_adState createState() => _catger_read_adState();
}

class _catger_read_adState extends State<catger_read_ad> {
  ScrollController myScroll;
  GlobalKey<RefreshIndicatorState> refreshKey;
  int i = 0;
  bool loadingList = false;

  String cat_name;
  void getDataCategory(int count, String strSearch) async {
    loadingList = true;

    setState(() {});
    List arr = await getData(count, "category/readcategory.php", strSearch,
        "");
    for (int i = 0; i < arr.length; i++) {
      categoryList_use.add(new CategoryData_use(
        use_id: arr[i]["use_id"],
        cat_name: arr[i]["cat_name"],
        cat_name_en: arr[i]["cat_name_en"],
        cat_regdate: arr[i]["cat_regdate"],
        cat_thumbnail: arr[i]["cat_thumbnail"],
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
    categoryList_use.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryList_use = new List<CategoryData_use>();
    myScroll = new ScrollController();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    getDataCategory(0, "");

    myScroll.addListener(() {
      if (myScroll.position.pixels == myScroll.position.maxScrollExtent) {
        i += 10;
        getDataCategory(i, "");
        print("scroll");
      }
    });
  }

  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text("ادارة التصنيفات");

  void _searchPressed(LoadingControl myProv) {
    if (this._searchIcon.icon == Icons.search) {
      this._searchIcon = new Icon(Icons.close);
      this._appBarTitle = new TextField(
        style: TextStyle(color: Colors.white),
        decoration: new InputDecoration(
            prefixIcon: Icon(Icons.search), hintText: "ابحث ..."),
        onChanged: (text) {
          print(text);

          categoryList_use.clear();
          i = 0;
          getDataCategory(0, text);
          myProv.add_loading();
        },
      );
    } else {
      this._searchIcon = new Icon(Icons.search);
      this._appBarTitle = new Text("بحث باسم التصنيف");
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
          categoryList_use.clear();
          await getDataCategory(0, "");
        },
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 0),
                child: ListView.builder(
                  controller: myScroll,
                  itemCount: categoryList_use.length,
                  itemBuilder: (context, index) {
                    return SingleCategory_ad(
                      cat_index: index,
                      category: categoryList_use[index],

                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

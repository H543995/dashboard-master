import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard/pages/component/progress.dart';
import 'package:dashboard/pages/config.dart';
import 'package:dashboard/pages/food/edit.dart';
import 'package:dashboard/pages/food/food_data.dart';
import 'package:dashboard/pages/function.dart';
import 'package:dashboard/pages/provider/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';


class Food_ad extends StatefulWidget {
  final String cat_name;

  int foo_index;
  FoodData food;
  String use_id;

  Food_ad({this.cat_name, this.foo_index, this.food, this.use_id});

  @override
  _Food_adState createState() => _Food_adState();
}

class _Food_adState extends State<Food_ad> {
  ScrollController myScroll;
  GlobalKey<RefreshIndicatorState> refreshKey;
  int i = 0;
  bool loadingList = false;
  void getDataFood(int count, String strSearch) async {
    loadingList = true;
    setState(() {});
    List arr = await getData(count,
        "food/readfood_user.php?use_id=${widget.use_id}&", strSearch, "");
    for (int i = 0; i < arr.length; i++) {
      foodList.add(new FoodData(
        foo_id: arr[i]["foo_id"],
        use_id: arr[i]["use_id"],
        cat_name: arr[i]["cat_name"],
        foo_name: arr[i]["foo_name"],
        foo_name_en: arr[i]["foo_name_en"],
        foo_price: arr[i]["foo_price"],
        foo_offer: arr[i]["foo_offer"],
        foo_info: arr[i]["foo_info"],
        foo_info_en: arr[i]["foo_info_en"],
        foo_regdate: arr[i]["foo_regdate"],
        foo_thumbnail: arr[i]["foo_thumbnail"],
        foo_image: arr[i]["foo_image"],
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
    foodList.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appBarTitle = new Text("hamza");
    foodList = new List<FoodData>();
    myScroll = new ScrollController();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    getDataFood(0, "");

    myScroll.addListener(() {
      if (myScroll.position.pixels == myScroll.position.maxScrollExtent) {
        i += 10;
        getDataFood(i, "");
        print("scroll");
      }
    });
  }

  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle;

  void _searchPressed(LoadingControl myProv) {
    if (this._searchIcon.icon == Icons.search) {
      this._searchIcon = new Icon(Icons.close);
      this._appBarTitle = new TextField(
        style: TextStyle(color: Colors.white),
        decoration: new InputDecoration(
            prefixIcon: Icon(Icons.search), hintText: "ابحث ..."),
        onChanged: (text) {
          print(text);

          foodList.clear();
          i = 0;
          getDataFood(0, text);
          myProv.add_loading();
        },
      );
    } else {
      this._searchIcon = new Icon(Icons.search);
      this._appBarTitle = new Text("بحث باسم المأكولات");
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
          foodList.clear();
          await getDataFood(0, "");
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
                  itemCount: foodList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = foodList[index];
                    return Dismissible(
                      key: Key(item.foo_id),
                      direction: DismissDirection.startToEnd,
                      child: SingleProduct_use(
                        foo_index: index,
                        food: foodList[index],
                      ),
                      onDismissed: (direction) {
                        foodList.remove(item);
                        deleteData(
                            "foo_id", item.foo_id, "food/delete_food.php");
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
    );
  }
}

class SingleProduct_use extends StatelessWidget {
  int foo_index;
  FoodData food;
  SingleProduct_use({this.foo_index, this.food});
  @override
  Widget build(BuildContext context) {
    var providerFood = Provider.of<LoadingControl>(context);
    return Card(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              foodList.removeAt(foo_index);
              deleteData("foo_id", food.foo_id, "food/delete_food.php");
              providerFood.add_loading();
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
              leading: food.foo_thumbnail == null || food.foo_thumbnail == ""
                  ? CachedNetworkImage(
                      imageUrl: imageFood + "def.png",
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )
                  : CachedNetworkImage(
                      imageUrl: imageFood + food.foo_thumbnail,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
              title: Text(
                food.foo_name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(food.foo_regdate)]),
              trailing: Container(
                width: 30.0,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new EditFood(
                                    foo_index: foo_index,
																		myfood: food,
																	use_id:food.use_id,
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
